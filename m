From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 00/21] IOMMU: Tegra GART driver clean up and
	optimization
Date: Tue, 11 Dec 2018 16:22:31 +0300
Message-ID: <0eb25577-cd64-11d5-1de6-8efa129b3b7b@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
	<20181211095317.tv43aaefnsezmic7@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181211095317.tv43aaefnsezmic7-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11.12.2018 12:53, Joerg Roedel wrote:
> On Sun, Dec 09, 2018 at 11:29:29PM +0300, Dmitry Osipenko wrote:
>> Dmitry Osipenko (21):
>>   iommu/tegra: gart: Remove pr_fmt and clean up includes
>>   iommu/tegra: gart: Clean up driver probe errors handling
>>   iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
>>   iommu: Introduce iotlb_sync_map callback
>>   iommu/tegra: gart: Optimize mapping / unmapping performance
>>   dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
>>   ARM: dts: tegra20: Update Memory Controller node to the new binding
>>   memory: tegra: Don't invoke Tegra30+ specific memory timing setup on
>>     Tegra20
>>   memory: tegra: Adapt to Tegra20 device-tree binding changes
>>   memory: tegra: Read client ID on GART page fault
>>   memory: tegra: Use of_device_get_match_data()
>>   memory: tegra: Use relaxed versions of readl/writel
>>   iommu/tegra: gart: Integrate with Memory Controller driver
>>   iommu/tegra: gart: Fix spinlock recursion
>>   iommu/tegra: gart: Fix NULL pointer dereference
>>   iommu/tegra: gart: Allow only one active domain at a time
>>   iommu/tegra: gart: Don't use managed resources
>>   iommu/tegra: gart: Prepend error/debug messages with "gart:"
>>   iommu/tegra: gart: Don't detach devices from inactive domains
>>   iommu/tegra: gart: Simplify clients-tracking code
>>   iommu/tegra: gart: Perform code refactoring
> 
> This is making progress, but some parts have no Ack or Review yet, I'll
> wait for Thierry before applying these patches into the iommu tree.

Okay, waiting.. zZZ :) Pretty much all of the patches are actually reviewed, those that are missing review/ack tags just have changes that were requested in a review comments to the previous version of the series. I hope it won't take much time to finalize the review of the patches.

Thierry, could you please acknowledge that you'll come back to these patches? More than two months passed since the last time you were replying regarding this series.
