From: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 0/4] Optimise 64-bit IOVA allocations
Date: Wed, 26 Jul 2017 19:17:28 +0800
Message-ID: <59787A48.6060200@huawei.com>
References: <cover.1500636791.git.robin.murphy@arm.com>
	<20170726110807.GN15833@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170726110807.GN15833-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 2017/7/26 19:08, Joerg Roedel wrote:
> Hi Robin.
> 
> On Fri, Jul 21, 2017 at 12:41:57PM +0100, Robin Murphy wrote:
>> Hi all,
>>
>> In the wake of the ARM SMMU optimisation efforts, it seems that certain
>> workloads (e.g. storage I/O with large scatterlists) probably remain quite
>> heavily influenced by IOVA allocation performance. Separately, Ard also
>> reported massive performance drops for a graphical desktop on AMD Seattle
>> when enabling SMMUs via IORT, which we traced to dma_32bit_pfn in the DMA
>> ops domain getting initialised differently for ACPI vs. DT, and exposing
>> the overhead of the rbtree slow path. Whilst we could go around trying to
>> close up all the little gaps that lead to hitting the slowest case, it
>> seems a much better idea to simply make said slowest case a lot less slow.
> 
> Do you have some numbers here? How big was the impact before these
> patches and how is it with the patches?
Here are some numbers:

(before)$ iperf -s
------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
[  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 35898
[ ID] Interval       Transfer     Bandwidth
[  4]  0.0-10.2 sec  7.88 MBytes  6.48 Mbits/sec
[  5] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 35900
[  5]  0.0-10.3 sec  7.88 MBytes  6.43 Mbits/sec
[  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 35902
[  4]  0.0-10.3 sec  7.88 MBytes  6.43 Mbits/sec

(after)$ iperf -s
------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
[  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 36330
[ ID] Interval       Transfer     Bandwidth
[  4]  0.0-10.0 sec  1.09 GBytes   933 Mbits/sec
[  5] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 36332
[  5]  0.0-10.0 sec  1.10 GBytes   939 Mbits/sec
[  4] local 192.168.1.106 port 5001 connected with 192.168.1.198 port 36334
[  4]  0.0-10.0 sec  1.10 GBytes   938 Mbits/sec

> 
> 
> 	Joerg
> 
> 
> .
> 

-- 
Thanks!
BestRegards
