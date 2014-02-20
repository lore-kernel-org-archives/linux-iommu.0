From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: fixes for 3.14
Date: Thu, 20 Feb 2014 13:14:26 +0100
Message-ID: <20140220121426.GH11432@8bytes.org>
References: <20140210183232.GH12826@mudshark.cambridge.arm.com>
	<20140218175027.GE11432@8bytes.org>
	<20140218183626.GC2010@mudshark.cambridge.arm.com>
	<20140218192137.GJ2010@mudshark.cambridge.arm.com>
	<20140220112919.GG11432@8bytes.org>
	<20140220115127.GH3615@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140220115127.GH3615-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Thu, Feb 20, 2014 at 11:51:27AM +0000, Will Deacon wrote:
> > Can the arm_smmu_devices_lock also be used in a DMA-API path?
> 
> I don't think so -- that lock is only taken when:
> 
>   - Probing the SMMU
>   - Attaching a device to a domain (->attach_dev)
>   - Adding or removing a device to/from the SMMU (->{add,remove}_device)

Okay, fine then.

> 
> > I also think that the parameter renaming should not be done in a fixup
> > patch, if you want it to be converted please include a renaming patch in
> > your updates for the next merge window.
> 
> Sure, that's just a cosmetic thing anyway.
> For your patch below,
> 
>   Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Thanks, I queued the patch with your Ack ontop of the fixes and will
send them out to Linus after a day in next or so.


Cheers,

	Joerg
