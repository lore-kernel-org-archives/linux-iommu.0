From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/4] iommu/of: Don't call iommu_ops->add_device directly
Date: Fri, 11 Jan 2019 11:23:29 +0100
Message-ID: <20190111102328.hm6y4chellntpnhl@8bytes.org>
References: <20181211150513.15161-1-joro@8bytes.org>
 <CGME20181211150640epcas5p4ffdd63a1900ebfe4a04eea24d2c86de6@epcas5p4.samsung.com>
 <20181211150513.15161-4-joro@8bytes.org>
 <30d86186-e0a2-2be1-2295-20510fbd74ba@samsung.com>
 <20181219143451.GY16835@8bytes.org>
 <CAMuHMdXr5tVuWf4dJzBLRfdqpMCMBSg-+t35nb=Rmh9PM=abJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXr5tVuWf4dJzBLRfdqpMCMBSg-+t35nb=Rmh9PM=abJg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, Sudeep Holla <sudeep.holla@arm.com>, Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: iommu@lists.linux-foundation.org


Hi Geert,

On Thu, Dec 20, 2018 at 04:42:17PM +0100, Geert Uytterhoeven wrote:
> > -       return ops->add_device(dev);
> > +       if (ops)
> 
> Is this sufficient? The old code checked for ops->add_device != NULL,
> too.

Robin brought up that all iommu-ops implementations support the
add_device call-back, so we can remove that check and make the call-back
mandatory for new implementations too.

Regards,

	Joerg
