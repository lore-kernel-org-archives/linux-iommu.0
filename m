From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 0/12] iommu/exynos: Fixes and Enhancements of System MMU
	driver with DT
Date: Tue, 20 Nov 2012 16:37:22 +0900
Message-ID: <CAHQjnOMke6661jE5YL8np=-PrU6rYCShxshom4DuA92BNGqOCQ@mail.gmail.com>
References: <001a01cdc6f0$d06c1f90$71445eb0$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6161590595153925903=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <001a01cdc6f0$d06c1f90$71445eb0$%cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sanghyun Lee <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============6161590595153925903==
Content-Type: multipart/alternative; boundary=f46d042d058cf68a4a04cee84d2d

--f46d042d058cf68a4a04cee84d2d
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Nov 20, 2012 at 4:29 PM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Patch summary:
> [PATCH v2 01/12] ARM: EXYNOS: remove system mmu initialization from
arch/arm/ tree
> [PATCH v2 02/12] ARM: EXYNOS: Add clk_ops for gating clocks of System MMU
> [PATCH v2 03/12] ARM: EXYNOS: add System MMU definition to DT
> [PATCH v2 04/12] iommu/exynos: support for device tree
> [PATCH v2 05/12] iommu/exynos: pass version information from DT
> [PATCH v2 06/12] iommu/exynos: allocate lv2 page table from own slab
> [PATCH v2 07/12] iommu/exynos: change rwlock to spinlock
> [PATCH v2 08/12] iommu/exynos: set System MMU as the parent of client
device
> [PATCH v2 09/12] iommu/exynos: add supoort for runtime pm and
suspend/resume
> [PATCH v2 10/12] iommu/exynos: add support for System MMU 3.2 and 3.3
> [PATCH v2 11/12] iommu/exynos: add literal name of System MMU for
debugging
> [PATCH v2 12/12] iommu/exynos: add debugfs entries for System MMU
>

It is required to be merged from the patch 01/12 to 09/12 for correct
working with DT and power management.
Patch 10/12 is required to support new version of System MMU that is IOMMU
in Exynos cores.
Patch 11/12 and 12/12 is adding debugging features.

Thank you.

Cho KyongHo.

--f46d042d058cf68a4a04cee84d2d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2012 at 4:29 PM, Cho KyongHo &lt;<a href=3D"mailto:pullip.c=
ho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote:<br>&gt; Patch summary=
:<br>&gt; [PATCH v2 01/12] ARM: EXYNOS: remove system mmu initialization fr=
om arch/arm/ tree<br>
&gt; [PATCH v2 02/12] ARM: EXYNOS: Add clk_ops for gating clocks of System =
MMU<br>&gt; [PATCH v2 03/12] ARM: EXYNOS: add System MMU definition to DT<b=
r>&gt; [PATCH v2 04/12] iommu/exynos: support for device tree<br>&gt; [PATC=
H v2 05/12] iommu/exynos: pass version information from DT<br>
&gt; [PATCH v2 06/12] iommu/exynos: allocate lv2 page table from own slab<b=
r>&gt; [PATCH v2 07/12] iommu/exynos: change rwlock to spinlock<br>&gt; [PA=
TCH v2 08/12] iommu/exynos: set System MMU as the parent of client device<b=
r>
&gt; [PATCH v2 09/12] iommu/exynos: add supoort for runtime pm and suspend/=
resume<br>&gt; [PATCH v2 10/12] iommu/exynos: add support for System MMU 3.=
2 and 3.3<br>&gt; [PATCH v2 11/12] iommu/exynos: add literal name of System=
 MMU for debugging<br>
&gt; [PATCH v2 12/12] iommu/exynos: add debugfs entries for System MMU<br>&=
gt;<br><br>It is required to be merged from the patch 01/12 to 09/12 for co=
rrect working with DT and power management.<br>Patch 10/12 is required to s=
upport new version of System MMU that is IOMMU in Exynos cores.<br>
Patch 11/12 and 12/12 is adding debugging features.<br><br>Thank you.<br><b=
r>Cho KyongHo.<br>

--f46d042d058cf68a4a04cee84d2d--

--===============6161590595153925903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6161590595153925903==--
