From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/omap: Fix debug_read_tlb() to use seq_printf()
Date: Mon, 3 Aug 2015 17:25:58 +0200
Message-ID: <20150803152557.GF20968@8bytes.org>
References: <1437654379-13356-1-git-send-email-speirofr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437654379-13356-1-git-send-email-speirofr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Salva =?iso-8859-1?Q?Peir=F3?= <speirofr@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 23, 2015 at 02:26:19PM +0200, Salva Peir=F3 wrote:
> The debug_read_tlb() uses the sprintf() functions directly on the buf=
fer
> allocated by buf =3D kmalloc(count), without taking into account the =
size
> of the buffer, with the consequence corrupting the heap, depending on
> the count requested by the user.
>=20
> The patch fixes the issue replacing sprintf() by seq_printf().
>=20
> Signed-off-by: Salva Peir=F3 <speirofr@gmail.com>
> ---
>  drivers/iommu/omap-iommu-debug.c | 26 +++++++-------------------
>  drivers/iommu/omap-iommu.c       | 28 +++++++++++-----------------
>  drivers/iommu/omap-iommu.h       |  3 +--
>  3 files changed, 19 insertions(+), 38 deletions(-)

Applied, thanks. I had to rebase it on top of Suman's changes, but that
wasn't too hard.
