From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] IOMMU Updates for Linux v4.19
Date: Fri, 24 Aug 2018 13:14:07 -0700
Message-ID: <CA+55aFz08bncAD=Q_1NO87YO_z9rTkUShSZ0V2wCMRSNY_WH4w@mail.gmail.com>
References: <20180824130120.lwv5bklvv64hjsde@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824130120.lwv5bklvv64hjsde@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm+renesas@opensource.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 24, 2018 at 6:01 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> note that this time there is a trivial conflict when merging this into
> your tree. The conflict is in drivers/iommu/ipmmu-vmsa.c, apparently
> some other tree also added DT matching entries there.

No, the IOMMU_OF_DECLARE() thing went away entirely, so my merge
removes the entries your branch added..

They should be unnecessary, but I obviously can't test that driver, so
people should check that out.

           Linus
