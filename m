From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH] iommu/of: Only do IOMMU lookup for available ones
Date: Thu, 18 Jan 2018 22:58:23 +0800
Message-ID: <5A60B60F.6040602@rock-chips.com>
References: <20180103060920.23475-1-jeffy.chen@rock-chips.com>
	<20180117132808.s5henw63oseg3ufd@8bytes.org>
	<20180118144118.GA12394@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180118144118.GA12394-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

Thanks for your reply.

On 01/18/2018 10:41 PM, Will Deacon wrote:
>> >
>> >Makes sense to me, but I'd like to have an OK from Robin or Will (added
>> >to Cc) before applying this.
> I don't think this patch makes a lot of sense in isolation: the SMMU drivers
> themselves will likely still probe, and it's unclear what we should about
> DMA when an IOMMU is not deemed to be available. See:
>
> https://patchwork.kernel.org/patch/9681211/
>
> Jeffy -- are you solving a real issue here, or is this just an attempt at
> some cleanup?

hmmm, it's just a cleanup, but it seems like we already removed this 
of_iommu_init_fn in:
b0c560f7d8a4 iommu: Clean up of_iommu_init_fn

so this patch can be disregarded too :)
>
> Will
>
>
>
