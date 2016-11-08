From: Will Deacon <will.deacon@arm.com>
Subject: Re: Summary of LPC guest MSI discussion in Santa Fe
Date: Tue, 8 Nov 2016 19:10:22 +0000
Message-ID: <20161108191022.GA17771@arm.com>
References: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
 <20161103220205.37715b49@t450s.home>
 <20161108024559.GA20591@arm.com>
 <dae12190-1eb6-20a9-5740-9e5be8bb65fc@redhat.com>
 <20161108175457.GK20591@arm.com>
 <5822214F.2070500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5822214F.2070500@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Don Dutile <ddutile@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, drjones@redhat.com, jason@lakedaemon.net, kvm@vger.kernel.org, marc.zyngier@arm.com, benh@kernel.crashing.org, joro@8bytes.org, punit.agrawal@arm.com, linux-kernel@vger.kernel.org, arnd@arndb.de, diana.craciun@nxp.com, iommu@lists.linux-foundation.org, pranav.sawargaonkar@gmail.com, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, tglx@linutronix.de, robin.murphy@arm.com, dwmw@amazon.co.uk, christoffer.dall@linaro.org, eric.auger.pro@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 08, 2016 at 02:02:39PM -0500, Don Dutile wrote:
> On 11/08/2016 12:54 PM, Will Deacon wrote:
> >A first step would be making all this opt-in, and only supporting GICv3
> >ITS for now.
> You're trying to support a config that is < GICv3 and no ITS ? ...
> That would be the equiv. of x86 pre-intr-remap, and that's why allow_unsafe_interrupts
> hook was created ... to enable devel/kick-the-tires.

Yup, that's exactly what I was envisaging. For systems that can't do
passthrough safely, we'll always have to throw a devel switch.

Will
