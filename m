From: Tomasz Nowicki <tnowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V2 0/1] Optimise IOVA allocations for PCI devices
Date: Thu, 12 Oct 2017 12:08:52 +0200
Message-ID: <f7210a76-399c-3767-74d0-24a98cbf7d78@caviumnetworks.com>
References: <1505897522-9237-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
	<cda4f03f-acf5-9b74-d8f1-774065bfc94e@semihalf.com>
	<20171012100444.GI30803@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171012100444.GI30803-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: Jayachandran.Nair-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Tomasz Nowicki <tomasz.nowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ganapatrao.Kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 12.10.2017 12:04, Joerg Roedel wrote:
> Hi Tomasz,
> 
> On Thu, Oct 12, 2017 at 11:40:27AM +0200, Tomasz Nowicki wrote:
>> Can you please have a look and see if you are fine with this patch?
> 
> How do these changes relate to Robin's IOVA optimizations already in the
> iommu-tree?
> 

This is another optimization patch which does not conflict with Robin's 
patches.

Robin, please correct me if I am wrong.

Thanks,
Tomasz
