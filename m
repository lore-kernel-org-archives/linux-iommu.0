From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] Implement SMMU passthrough using the default domain
Date: Thu, 2 Feb 2017 10:02:50 -0500
Message-ID: <CAF6AEGtfrrwVZ_W86_HqVsiqfcM=XFa+g2LECFYQJmvv7-JSqQ@mail.gmail.com>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
	<010801d27654$47b7e450$d727acf0$@codeaurora.org>
	<20170126171857.GE27598@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170126171857.GE27598-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 26, 2017 at 12:18 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jan 24, 2017 at 08:42:23PM +0530, Sricharan wrote:
>> Thanks for this series. We had a case with the GPU.
>> The GPU's iommu was setup by kernel and the GPU
>> also does dynamic updates for on-the-fly switching between
>> process pagetables.  GPU driver was not using DMA domain and
>> the GPU's firmware was always expecting to run out  of contextbank
>>  '0' (although not correct) , which was not the case after the DMA domain
>> was made default  as '0' was getting allocated for DMA domain and
>> there were concerns about reusing the DMA domain as well.
>> Now with this series, looks there is an way out of that that can be tried.
>>
>> So should the default domain not be per device specific selectable ?
>
> Note that iommu-drivers can request direct-mapping for any given device
> on its initializtion. This is used on x86 for devices that need a 1-1
> mapping for some reason.
>
> Also device drivers can use the iommu-api and assign their own domain to
> a device, which allows them to manage the dma address space on their
> own.

Part of the problem is that dev->archdata.dma_ops gets wired up to
iommu_dma_ops.  Which isn't so bad on it's own, except that cache ops
are not exposed to drivers, forcing us to use dma-mapping API
(dma_map_sg, etc) for cache operations.

Possibly we should just expose cache op's to drivers bypass this abuse
of dma-mapping.

btw, Will, we definitely want this to *not* rely on kcmdline for the
gpu with it's own private iommu case..

BR,
-R
