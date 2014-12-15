From: Varun Sethi <Varun.Sethi@freescale.com>
Subject: RE: [PATCH 2/4] iommu: add ARM LPAE page table allocator
Date: Mon, 15 Dec 2014 16:35:12 +0000
Message-ID: <BN3PR0301MB12194A8F5CFF870B7A124623EA6F0@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
 <1417089078-22900-3-git-send-email-will.deacon@arm.com>
 <BN3PR0301MB12198CE5D736CDC6A221EDC2EA790@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <20141205184802.GH1203@arm.com>
 <BN3PR0301MB1219D3161E4E9DB314FDD8FAEA6E0@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <20141215133020.GJ20738@arm.com> <20141215154317.GL20738@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141215154317.GL20738@arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: "lauraa@codeaurora.org" <lauraa@codeaurora.org>, "mitchelh@codeaurora.org" <mitchelh@codeaurora.org>, "joro@8bytes.org" <joro@8bytes.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "prem.mallappa@broadcom.com" <prem.mallappa@broadcom.com>, Robin Murphy <Robin.Murphy@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

-----Original Message-----
From: Will Deacon [mailto:will.deacon@arm.com] 
Sent: Monday, December 15, 2014 9:13 PM
To: Sethi Varun-B16395
Cc: linux-arm-kernel@lists.infradead.org; iommu@lists.linux-foundation.org; prem.mallappa@broadcom.com; Robin Murphy; lauraa@codeaurora.org; mitchelh@codeaurora.org; laurent.pinchart@ideasonboard.com; joro@8bytes.org; m.szyprowski@samsung.com
Subject: Re: [PATCH 2/4] iommu: add ARM LPAE page table allocator

On Mon, Dec 15, 2014 at 01:30:20PM +0000, Will Deacon wrote:
> On Sun, Dec 14, 2014 at 05:45:49PM +0000, Varun Sethi wrote:
> > [varun] ok, but you could potentially end up splitting mapping to 
> > the least possible page size e.g. 4K. You, don't seem to take in to 
> > account the possibility of using the block size at the next level. 
> > For example, take a case where we have a huge page mapping using 1G 
> > page size and we have an unmap request for 4K. We could still split 
> > maximum part of the mapping using 2M pages at the next level. The 
> > entry where we need to unmap the 4K region would potentially go to the next level.
> 
> Aha, I see what you mean here, thanks. I'll take a look...

Scratch that, I think the code is fine as it is. For the case you highlight, we iterate over the 1GB region remapping it using 4k pages, but skipping the one we want to unmap, so I don't think there's a problem (__arm_lpae_map will create the relevant table entries).


[[varun]]  But you can split 1G in 2M mappings and then split up the unmapped region using 4K pages. In this case you split up the entire region using 4K pages.

Thanks,
Varun
