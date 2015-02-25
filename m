From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 linux-next] iommu: Enable LPAE pagetable on ARM and
 ARM64 only
Date: Wed, 25 Feb 2015 09:59:21 +0000
Message-ID: <20150225095921.GB20673@arm.com>
References: <3203874.zEMjzr0PS0@avalon>
 <1424737221-1193-1-git-send-email-vincent.stehle@laposte.net>
 <6851919.VIGEV8htgx@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6851919.VIGEV8htgx@avalon>
Sender: linux-next-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@laposte.net>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 24, 2015 at 12:23:48AM +0000, Laurent Pinchart wrote:
> On Tuesday 24 February 2015 01:20:21 Vincent Stehl=E9 wrote:
> > LPAE iommu page table makes sense only for ARM and ARM64 architectu=
res. Add
> > the corresponding dependency in Kconfig (and enable for COMPILE_TES=
T, too,
> > as per Laurent's suggestion).
> >=20
> > Signed-off-by: Vincent Stehl=E9 <vincent.stehle@laposte.net>
> > Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Will Deacon <will.deacon@arm.com>
>=20
> Now,
>=20
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Sorry guys, I've been away from email for the past couple of days, but =
I
already have an exact copy of this patch queued from somebody else!

  http://www.spinics.net/lists/arm-kernel/msg400030.html

Will
