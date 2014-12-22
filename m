From: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 0/2] Change order of linkage in kernel makefiles for amdkfd
Date: Mon, 22 Dec 2014 12:56:14 +0100
Message-ID: <549806DE.2080703@amd.com>
References: <1419246435-7050-1-git-send-email-oded.gabbay@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419246435-7050-1-git-send-email-oded.gabbay@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oded Gabbay <oded.gabbay@amd.com>, David Airlie <airlied@linux.ie>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, Jerome Glisse <j.glisse@gmail.com>, John Bridgman <John.Bridgman@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, Dana Elifaz <Dana.Elifaz@amd.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

=46or this series: Reviewed-by: Christian K=F6nig <christian.koenig@amd=
=2Ecom>

Am 22.12.2014 um 12:07 schrieb Oded Gabbay:
> This small patch-set, was created to solve the bug described at
> https://bugzilla.kernel.org/show_bug.cgi?id=3D89661 (Kernel panic whe=
n
> trying use amdkfd driver on Kaveri). It replaces the previous patch-s=
et called
> [PATCH 0/3] Use workqueue for device init in amdkfd
> (http://lists.freedesktop.org/archives/dri-devel/2014-December/074401=
=2Ehtml)
>
> That bug appears only when radeon, amdkfd and amd_iommu_v2 are compil=
ed
> inside the kernel (not as modules). In that case, the correct loading
> order, as determined by the exported symbol used by each driver, is
> not enforced anymore and the kernel loads them based on who was linke=
d
> first. That makes radeon load first, amdkfd second and amd_iommu_v2
> third.
>
> Because the initialization of a device in amdkfd is initiated by rade=
on,
> and can only be completed if amdkfd and amd_iommu_v2 were loaded and
> initialized, then in the case mentioned above, this initalization fai=
ls
> and there is a kernel panic as some pointers are not initialized but
> used nontheless.
>
> To solve this bug, this patch-set moves iommu/ before gpu/ in drivers=
/Makefile
> and also moves amdkfd/ before radeon/ in drivers/gpu/drm/Makefile.
>
> The rationale is that in general, AMD GPU devices are dependent on AM=
D IOMMU
> controller functionality to allow the GPU to access a process's virtu=
al memory
> address space, without the need for pinning the memory. That's why it=
 makes
> sense to initialize the iommu/ subsystem ahead of the gpu/ subsystem.
>
> 	Oded
>
> Oded Gabbay (2):
>    drivers: Move iommu/ before gpu/ in Makefile
>    drm: Put amdkfd before radeon in drm Makefile
>
>   drivers/Makefile         | 6 ++++--
>   drivers/gpu/drm/Makefile | 2 +-
>   2 files changed, 5 insertions(+), 3 deletions(-)
>
