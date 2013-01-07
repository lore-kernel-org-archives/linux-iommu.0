From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v6 00/12] iommu/exynos: Fixes and Enhancements of System
	MMU driver with DT
Date: Mon, 7 Jan 2013 19:45:47 +0900
Message-ID: <CAHQjnOMxYo1D6EgX6ZnGBm_Ufr+u4hgKQzAyQdXJGhiC3XpKdA@mail.gmail.com>
References: <003301cde30b$c584c2d0$508e4870$%cho@samsung.com>
	<50E611D5.5040909@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7952918516795421659=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <50E611D5.5040909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Hyunwoong Kim <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Subash Patel <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============7952918516795421659==
Content-Type: multipart/alternative; boundary=f46d044304dc31504704d2b088ec

--f46d044304dc31504704d2b088ec
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: quoted-printable

2013. 1. 4. =BF=C0=C0=FC 8:32=BF=A1 "Sylwester Nawrocki" <sylvester.nawrock=
i@gmail.com>=B4=D4=C0=CC
=C0=DB=BC=BA:
>
> Hi,
>
> Cc: devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
>
>
> On 12/26/2012 02:53 AM, Cho KyongHo wrote:
>>
>> notice: v6 patch-set is rebased on next/iommu-exynos branch of
>> linux-samsung.git.  This patch-set does not include 2 patches (05 and 06
>> patches in v5 patch-se) because they alread exist already in the branch.
>>
>> The current exynos-iommu(System MMU) driver does not work autonomously
>> since it is lack of support for power management of peripheral blocks.
>> For example, MFC device driver must ensure that its System MMU is
disabled
>> before MFC block is power-down not to invalidate IOTLB in the System MMU
>> when I/O memory mapping is changed. Because A System MMU is resides in
the
>> same H/W block, access to control registers of System MMU while the H/W
>> block is turned off must be prohibited.
>>
>> This set of changes solves the above problem with setting each System
MMUs
>> as the parent of the device which owns the System MMU to recieve the
>> information when the device is turned off or turned on.
>
>
> I intend to make Exynos4412 FIMC-LITEn (Exynos5 CAMIFn) devices child
> devices of the FIMC-IS (camera ISP) platform device. This patch reflects
> that: http://patchwork.linuxtv.org/patch/16046
>
> This is required since AFAIK FIMC-LITE depends on clocks from FIMC-IS.
> By setting fimc-is device as the parent fimc-lite's dependency on it is
> resolved without any hacks between these drivers.
>
> Then how this tree will look like after your sysmmu related re-parenting:
>
>          fimc-is
>         /      \
>  fimc-lite0    fimc-lite1
>
>
> ?

First of all, I think that clock dependency shuold be resolved with setting
the parent of clock descriptor of fimc-lite  to the clock descriptor of
fimc-is.
If you are concerning about power management, it is simply resolved with
putting fimc-lite to the power domain of fimc-is.
The above tree will be changed like below after probing System MMU:
sysmmu-fimc-is
            I
     fimc-is

sysmmu-fimc-lite0
              I
      fimc-lite0

sysmmu-fimc-lite1
             I
       fimc-lite1

>> Another big change to the driver is the support for devicetree.
>> The bindings for System MMU is described in
>> Documentation/devicetree/bindings/arm/samsung/system-mmu.txt
>
>
> Yes, and there is no patch adding this file in this series. Let me paste
> it here:
>
> From 88987ff5b77acc7211b9f537a6ef6ea38e3efdd0 Mon Sep 17 00:00:00 2001
> From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Date: Tue, 11 Dec 2012 14:06:25 +0900
> Subject: [PATCH] ARM: EXYNOS: add System MMU definition to DT
>
> This commit adds System MMU nodes to DT of Exynos SoCs.
>
> Signed-off-by: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../devicetree/bindings/arm/exynos/system-mmu.txt  |   86 ++++++++++++
>  arch/arm/boot/dts/exynos4210.dtsi                  |   96 +++++++++++++
>  arch/arm/boot/dts/exynos4x12.dtsi                  |  124
+++++++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi                  |  147
+++++++++++++++++++-
>  4 files changed, 451 insertions(+), 2 deletions(-)
>  create mode 100644
Documentation/devicetree/bindings/arm/exynos/system-mmu.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/exynos/system-mmu.txt
b/Documentation/devicetree/bindings/arm/exynos/system-mmu.txt
> new file mode 100644
> index 0000000..b33d682
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/exynos/system-mmu.txt
> @@ -0,0 +1,86 @@
> +* Samsung Exynos System MMU
> +
> +Samsung's Exynos architecture includes System MMU that enables scattered
> +physical chunks to be visible as a contiguous region to DMA-capabile
peripheral
> +devices like MFC, FIMC, FIMD, GScaler, FIMC-IS and so forth.
> +
> +System MMU is a sort of IOMMU and support identical translation table
format to
> +ARMv7 translation tables with minimum set of page properties including
access
> +permissions, shareability and security protection. In addition System
MMU has
> +another capabilities like L2 TLB or block-fetch buffers to minimize
translation
> +latency
> +
> +Each System MMU is included in the H/W block of a peripheral device.
Thus, it is
> +important to specify that a System MMU is dedicated to which peripheral
device
> +before using System MMU. System initialization must specify the
relationships
> +between a System MMU and a peripheral device that owns the System MMU.
> +
> +Some device drivers may control several peripheral devices with a single
device
> +descriptor like MFC. Since handling a System MMU with IOMMU API requires
a
> +device descriptor that needs the System MMU, it is best to combine the
System
> +MMUs of the peripheral devices and control them with a single System MMU
device
> +descriptor. If it is unable to combine them into a single device
descriptor,
> +they can be linked with each other by the means of device.parent
relationship.
> +
> +Required properties:
> +- compatible: Should be "samsung,exynos-sysmmu".
> +- reg: Tuples of base address and size of System MMU registers. The
number of
> +       tuples can be more than one if two or more System MMUs are
controlled
> +       by a single device descriptor.
> +- interrupt-parent: The phandle of the interrupt controller of System MM=
U
> +- interrupts: Tuples of numbers that indicates the interrupt source. The
> +              number of elements in the tuple is dependent upon
> +             'interrupt-parent' property. The number of tuples in this
property
> +             must be the same with 'reg' property.
> +
> +Optional properties:
> +- mmuname: Strings of the name of System MMU for debugging purpose. The
number
> +          of strings must be the same with the number of tuples in 'reg'
> +          property.
>
> As commented on previous patch, this isn't something that belongs here.
> But for debugging you could probably retrieve this from the node name ?

Thank you for good idea. However mmuname is an array of strings, actually.
Anyway I agree with your opinion that 'mmuname' is not proper property of a
device node. I will remove it and substitute it with base register address
of a System MMU.
>
> +- mmu-master: phandle to the device node that owns System MMU. Only the
device
> +          that is specified whith this property can control System MMU
with
> +          IOMMU API.
> +
> +Examples:
> +
> +MFC has 2 System MMUs for each port that MFC is attached. Thus it seems
natural
> +to define 2 System MMUs for each port of the MFC:
> +
> +       sysmmu-mfc-l {
> +               mmuname =3D "mfc_l";
> +               reg =3D <0x11210000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <8 5>;
> +               mmu-master =3D <&mfc>;
> +       };
> +
> +       sysmmu-mfc-r {
> +               mmuname =3D "mfc_r";
> +               reg =3D <0x11200000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <6 2>;
> +               mmu-master =3D <&mfc>;
> +       };
> +
> +Actually, MFC device driver requires sub-devices that represents each
port and
> +above 'mmu-master' properties of sysmmu-mfc-l and sysmmu-mfc-r have the
phandles
> +to those sub-devices.
>
> I find this sentence really difficult to parse. This documentation should
talk
> about how the device is designed and represented, rather than about its
driver.
>
OK. I will trying to find another expression easy to understand.  Do you
have any suggestion?

> +However, it is also a good idea that treats the above System MMUs as one
System
> +MMU because those System MMUs are actually required by the MFC device:
> +
> +       sysmmu-mfc {
> +               mmuname =3D "mfc_l", "mfc_r";
> +               reg =3D <0x11210000 0x1000
> +                      0x11200000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <8 5
> +                             6 2>;
> +               mmu-master =3D <&mfc>;
> +       };
> +
> +If System MMU of MFC is defined like the above, the number of elements
and the
> +order of list in 'mmuname', 'reg' and 'interrupts' must be the same.
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi
b/arch/arm/boot/dts/exynos4210.dtsi
> index e31bfc4..1c134b2 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -76,4 +76,100 @@
>                 reg =3D <0x100C0000 0x100>;
>                 interrupts =3D <2 4>;
>         };
> +
> +       sysmmu-mfcL {
>
> This capitalization looks weird. How about just making it sysmmu-mfc-l ?
OK. That looks better.
>
> +               mmuname =3D "mfc_l";
> +               reg =3D <0x13620000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <5 5>;
> +       };
> +
> +       sysmmu-mfcR {
>
> and sysmmu-mfc-r ?
>
> Hmm, you actually have it defined this way for exynos5250...
Oh really I did. I will make it better.
>
> +               mmuname =3D "mfc_r";
> +               reg =3D <0x13630000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <5 6>;
> +       };
> +
> +       sysmmu-tv {
> +               mmuname =3D "tv";
> +               reg =3D <0x13E20000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <5 4>;
> +       };
> +
> +       sysmmu-fimc0 {
> +               mmuname =3D "fimc0";
> +               reg =3D <0x11A20000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <4 2>;
> +       };
> +
> +       sysmmu-fimc1 {
> +               mmuname =3D "fimc1";
> +               reg =3D <0x11A30000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <4 3>;
> +       };
> +
> +       sysmmu-fimc2 {
> +               mmuname =3D "fimc2";
> +               reg =3D <0x11A40000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <4 4>;
> +       };
> +
> +       sysmmu-fimc3 {
> +               mmuname =3D "fimc3";
> +               reg =3D <0x11A50000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <4 5>;
> +       };
> +
> +       sysmmu-jpeg {
> +               mmuname =3D "jpeg";
> +               reg =3D <0x11A60000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <4 6>;
> +       };
> +
> +       sysmmu-g2d {
> +               mmuname =3D "g2d";
> +               reg =3D <0x12A20000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <4 7>;
> +       };
> +
> +       sysmmu-rotator {
> +               mmuname =3D "rotator";
> +               reg =3D <0x12A30000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <5 0>;
> +       };
> +
> +       sysmmu-fimd0 {
> +               mmuname =3D "fimd0";
> +               reg =3D <0x11E20000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <5 2>;
> +       };
> +
> +       sysmmu-fimd1 {
> +               mmuname =3D "fimd1";
> +               reg =3D <0x12220000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <5 3>;
> +       };
>  };
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi
b/arch/arm/boot/dts/exynos4x12.dtsi
> index 179a62e..0c6d001 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -66,4 +66,128 @@
>                 reg =3D <0x106E0000 0x1000>;
>                 interrupts =3D <0 72 0>;
>         };
> +
> +       sysmmu-mfcL {
> +               mmuname =3D "mfc_l";
> +               reg =3D <0x13620000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <5 5>;
> +       };
> +
> +       sysmmu-mfcR {
> +               mmuname =3D "mfc_r";
> +               reg =3D <0x13630000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <5 6>;
> +       };
> +
> +       sysmmu-tv {
> +               mmuname =3D "tv";
> +               reg =3D <0x13E20000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <5 4>;
> +       };
> +
> +       sysmmu-fimc0 {
> +               mmuname =3D "fimc0";
> +               reg =3D <0x11A20000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <4 2>;
> +       };
> +
> +       sysmmu-fimc1 {
> +               mmuname =3D "fimc1";
> +               reg =3D <0x11A30000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <4 3>;
> +       };
> +
> +       sysmmu-fimc2 {
> +               mmuname =3D "fimc2";
> +               reg =3D <0x11A40000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <4 4>;
> +       };
> +
> +       sysmmu-fimc3 {
> +               mmuname =3D "fimc3";
> +               reg =3D <0x11A50000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <4 5>;
> +       };
> +
> +       sysmmu-jpeg {
> +               mmuname =3D "jpeg";
> +               reg =3D <0x11A60000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <4 6>;
> +       };
> +
> +       sysmmu-g2d {
> +               mmuname =3D "g2d";
> +               reg =3D <0x10A40000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <4 7>;
> +       };
> +
> +       sysmmu-rotator {
> +               mmuname =3D "rotator";
> +               reg =3D <0x12A30000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <5 0>;
> +       };
> +
> +       sysmmu-fimd0 {
> +               mmuname =3D "fimd0";
> +               reg =3D <0x11E20000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <5 2>;
> +       };
> +
> +       sysmmu-is0 {
> +               mmuname =3D "isp", "drc", "fd";
> +               reg =3D < 0x12260000 0x1000
> +                       0x12270000 0x1000
> +                       0x122A0000 0x1000 >;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <  16 2
> +                               16 3
> +                               16 4 >;
> +       };
> +
> +       sysmmu-is1 {
> +               mmuname =3D "ispcpu";
> +               reg =3D <0x122B0000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <16 5>;
> +       };
> +
> +       sysmmu-flite0 {
> +               mmuname =3D "fimc-lite0";
> +               reg =3D <0x123B0000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <16 0>;
> +       };
> +
> +       sysmmu-flite1 {
> +               mmuname =3D "fimc-lite1";
> +               reg =3D <0x123C0000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <16 1>;
> +       };
>  };
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
b/arch/arm/boot/dts/exynos5250.dtsi
> index 2e3b6ef..2ff6d78 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -75,7 +75,7 @@
>                 interrupts =3D <0 42 0>;
>         };
>
> -       codec@11000000 {
> +       mfc: codec@11000000 {
>                 compatible =3D "samsung,mfc-v6";
>                 reg =3D <0x11000000 0x10000>;
>                 interrupts =3D <0 96 0>;
> @@ -578,9 +578,152 @@
>                 interrupts =3D <0 95 0>;
>         };
>
> -       mixer {
> +       mixer: mixer {
>                 compatible =3D "samsung,exynos5-mixer";
>                 reg =3D <0x14450000 0x10000>;
>                 interrupts =3D <0 94 0>;
>         };
> +
> +       sysmmu-mfc-l {
> +               mmuname =3D "mfc_l";
> +               reg =3D <0x11210000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <8 5>;
> +               mmu-master =3D <&mfc>;
> +       };
> +
> +       sysmmu-mfc-r {
> +               mmuname =3D "mfc_r";
> +               reg =3D <0x11200000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <6 2>;
> +               mmu-master =3D <&mfc>;
> +       };
> +
> +       sysmmu-tv {
> +               mmuname =3D "tv";
> +               reg =3D <0x14650000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <7 4>;
> +               mmu-master =3D <&mixer>;
> +       };
> +
> +       sysmmu-gsc0 {
> +               mmuname =3D "gsc0";
> +               reg =3D <0x13E80000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <2 0>;
> +               mmu-master =3D <&gsc_0>;
> +       };
> +
> +       sysmmu-gsc1 {
> +               mmuname =3D "gsc1";
> +               reg =3D <0x13E90000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <2 2>;
> +               mmu-master =3D <&gsc_1>;
> +       };
> +
> +       sysmmu-gsc2 {
> +               mmuname =3D "gsc2";
> +               reg =3D <0x13EA0000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <2 4>;
> +               mmu-master =3D <&gsc_2>;
> +       };
> +
> +       sysmmu-gsc3 {
> +               mmuname =3D "gsc3";
> +               reg =3D <0x13EB0000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <2 6>;
> +               mmu-master =3D <&gsc_3>;
> +       };
> +
> +       sysmmu-fimd1 {
> +               mmuname =3D "fimd1";
> +               reg =3D <0x14640000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <3 2>;
> +       };
> +
> +       sysmmu-rotator {
> +               mmuname =3D "rotator";
> +               reg =3D <0x11D40000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <4 0>;
> +       };
> +
> +       sysmmu-is0 {
> +               mmuname =3D "isp", "drc", "scalerc", "scalerp", "fd", "mc=
u";
> +               reg =3D < 0x13260000 0x1000
> +                       0x13270000 0x1000
> +                       0x13280000 0x1000
> +                       0x13290000 0x1000
> +                       0x132A0000 0x1000
> +                       0x132B0000 0x1000 >;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <  10 6
> +                               11 6
> +                                5 2
> +                                3 6
> +                                5 0
> +                                5 4 >;
>
> I believe this should be
>
>                 interrupts =3D <10 6>, <11 6>, <5 2>,
>                              <3 6>, <5 0>, <5 4>;
>
I found the syntax of array of resources in the specifications of device
tree. I found that it works correctly.
> +       };
> +
> +       sysmmu-is1 {
> +               mmuname =3D "odc", "dis0", "dis1", "3dnr";
> +               reg =3D < 0x132C0000 0x1000
> +                       0x132D0000 0x1000
> +                       0x132E0000 0x1000
> +                       0x132F0000 0x1000 >;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <  11 0
> +                               10 4
> +                                9 4
> +                                5 6 >;
>
> Ditto.
>
> +       };
> +
> +       sysmmu-2d {
> +               mmuname =3D "2d";
> +               reg =3D <0x10A60000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <24 5>;
> +       };
> +
> +       sysmmu-jpeg {
> +               mmuname =3D "jpeg";
> +               reg =3D <0x11F20000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <4 2>;
> +       };
> +
> +       sysmmu-flite0 {
> +               mmuname =3D "flite0";
> +               reg =3D <0x13C40000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <3 4>;
> +       };
> +
> +       sysmmu-flite1 {
> +               mmuname =3D "flite1";
> +               reg =3D <0x13C50000 0x1000>;
> +               compatible =3D "samsung,exynos-sysmmu";
> +               interrupt-parent =3D <&combiner>;
> +               interrupts =3D <24 1>;
> +       };
>  };
>
> --
>
> Thanks,
> Sylwester
>
Thank you for kind review.

KyongHo

--f46d044304dc31504704d2b088ec
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
2013. 1. 4. =EC=98=A4=EC=A0=84 8:32=EC=97=90 &quot;Sylwester Nawrocki&quot;=
 &lt;<a href=3D"mailto:sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">sylvester.nawrocki@gma=
il.com</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; Cc: devicetree-discuss &lt;<a href=3D"mailto:devicetree-discuss@lists.=
ozlabs.org">devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org</a>&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 12/26/2012 02:53 AM, Cho KyongHo wrote:<br>
&gt;&gt;<br>
&gt;&gt; notice: v6 patch-set is rebased on next/iommu-exynos branch of<br>
&gt;&gt; linux-samsung.git. =C2=A0This patch-set does not include 2 patches=
 (05 and 06<br>
&gt;&gt; patches in v5 patch-se) because they alread exist already in the b=
ranch.<br>
&gt;&gt;<br>
&gt;&gt; The current exynos-iommu(System MMU) driver does not work autonomo=
usly<br>
&gt;&gt; since it is lack of support for power management of peripheral blo=
cks.<br>
&gt;&gt; For example, MFC device driver must ensure that its System MMU is =
disabled<br>
&gt;&gt; before MFC block is power-down not to invalidate IOTLB in the Syst=
em MMU<br>
&gt;&gt; when I/O memory mapping is changed. Because A System MMU is reside=
s in the<br>
&gt;&gt; same H/W block, access to control registers of System MMU while th=
e H/W<br>
&gt;&gt; block is turned off must be prohibited.<br>
&gt;&gt;<br>
&gt;&gt; This set of changes solves the above problem with setting each Sys=
tem MMUs<br>
&gt;&gt; as the parent of the device which owns the System MMU to recieve t=
he<br>
&gt;&gt; information when the device is turned off or turned on.<br>
&gt;<br>
&gt;<br>
&gt; I intend to make Exynos4412 FIMC-LITEn (Exynos5 CAMIFn) devices child<=
br>
&gt; devices of the FIMC-IS (camera ISP) platform device. This patch reflec=
ts<br>
&gt; that: <a href=3D"http://patchwork.linuxtv.org/patch/16046">http://patc=
hwork.linuxtv.org/patch/16046</a><br>
&gt;<br>
&gt; This is required since AFAIK FIMC-LITE depends on clocks from FIMC-IS.=
<br>
&gt; By setting fimc-is device as the parent fimc-lite&#39;s dependency on =
it is<br>
&gt; resolved without any hacks between these drivers.<br>
&gt;<br>
&gt; Then how this tree will look like after your sysmmu related re-parenti=
ng:<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fimc-is<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0 =C2=A0 =C2=A0\<br>
&gt; =C2=A0fimc-lite0 =C2=A0 =C2=A0fimc-lite1<br>
&gt;<br>
&gt;<br>
&gt; ?</p>
<p>First of all, I think that clock dependency shuold be resolved with sett=
ing the parent of clock descriptor of fimc-lite=C2=A0 to the clock descript=
or of fimc-is.<br>
If you are concerning about power management, it is simply resolved with pu=
tting fimc-lite to the power domain of fimc-is.<br>
The above tree will be changed like below after probing System MMU:<br>
sysmmu-fimc-is<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I<br>
=C2=A0=C2=A0=C2=A0=C2=A0 fimc-is</p>
<p>sysmmu-fimc-lite0<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 I<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fimc-lite0</p>
<p>sysmmu-fimc-lite1<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I<=
br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fimc-lite1</p>
<p>&gt;&gt; Another big change to the driver is the support for devicetree.=
<br>
&gt;&gt; The bindings for System MMU is described in<br>
&gt;&gt; Documentation/devicetree/bindings/arm/samsung/system-mmu.txt<br>
&gt;<br>
&gt;<br>
&gt; Yes, and there is no patch adding this file in this series. Let me pas=
te<br>
&gt; it here:<br>
&gt;<br>
&gt; From 88987ff5b77acc7211b9f537a6ef6ea38e3efdd0 Mon Sep 17 00:00:00 2001=
<br>
&gt; From: KyongHo Cho &lt;<a href=3D"mailto:pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">pullip=
.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
&gt; Date: Tue, 11 Dec 2012 14:06:25 +0900<br>
&gt; Subject: [PATCH] ARM: EXYNOS: add System MMU definition to DT<br>
&gt;<br>
&gt; This commit adds System MMU nodes to DT of Exynos SoCs.<br>
&gt;<br>
&gt; Signed-off-by: KyongHo Cho &lt;<a href=3D"mailto:pullip.cho-Sze3O3UU22KIwRZHo2/mJg@public.gmane.org=
m">pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
&gt; Signed-off-by: Kukjin Kim &lt;<a href=3D"mailto:kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org"=
>kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0.../devicetree/bindings/arm/exynos/system-mmu.txt =C2=A0| =C2=A0=
 86 ++++++++++++<br>
&gt; =C2=A0arch/arm/boot/dts/exynos4210.dtsi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 96 +++++++++++++<br>
&gt; =C2=A0arch/arm/boot/dts/exynos4x12.dtsi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0124 +++++++++++++++++<br>
&gt; =C2=A0arch/arm/boot/dts/exynos5250.dtsi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0147 +++++++++++++++++++-<br>
&gt; =C2=A04 files changed, 451 insertions(+), 2 deletions(-)<br>
&gt; =C2=A0create mode 100644 Documentation/devicetree/bindings/arm/exynos/=
system-mmu.txt<br>
&gt;<br>
&gt; diff --git a/Documentation/devicetree/bindings/arm/exynos/system-mmu.t=
xt b/Documentation/devicetree/bindings/arm/exynos/system-mmu.txt<br>
&gt; new file mode 100644<br>
&gt; index 0000000..b33d682<br>
&gt; --- /dev/null<br>
&gt; +++ b/Documentation/devicetree/bindings/arm/exynos/system-mmu.txt<br>
&gt; @@ -0,0 +1,86 @@<br>
&gt; +* Samsung Exynos System MMU<br>
&gt; +<br>
&gt; +Samsung&#39;s Exynos architecture includes System MMU that enables sc=
attered<br>
&gt; +physical chunks to be visible as a contiguous region to DMA-capabile =
peripheral<br>
&gt; +devices like MFC, FIMC, FIMD, GScaler, FIMC-IS and so forth.<br>
&gt; +<br>
&gt; +System MMU is a sort of IOMMU and support identical translation table=
 format to<br>
&gt; +ARMv7 translation tables with minimum set of page properties includin=
g access<br>
&gt; +permissions, shareability and security protection. In addition System=
 MMU has<br>
&gt; +another capabilities like L2 TLB or block-fetch buffers to minimize t=
ranslation<br>
&gt; +latency<br>
&gt; +<br>
&gt; +Each System MMU is included in the H/W block of a peripheral device. =
Thus, it is<br>
&gt; +important to specify that a System MMU is dedicated to which peripher=
al device<br>
&gt; +before using System MMU. System initialization must specify the relat=
ionships<br>
&gt; +between a System MMU and a peripheral device that owns the System MMU=
.<br>
&gt; +<br>
&gt; +Some device drivers may control several peripheral devices with a sin=
gle device<br>
&gt; +descriptor like MFC. Since handling a System MMU with IOMMU API requi=
res a<br>
&gt; +device descriptor that needs the System MMU, it is best to combine th=
e System<br>
&gt; +MMUs of the peripheral devices and control them with a single System =
MMU device<br>
&gt; +descriptor. If it is unable to combine them into a single device desc=
riptor,<br>
&gt; +they can be linked with each other by the means of device.parent rela=
tionship.<br>
&gt; +<br>
&gt; +Required properties:<br>
&gt; +- compatible: Should be &quot;samsung,exynos-sysmmu&quot;.<br>
&gt; +- reg: Tuples of base address and size of System MMU registers. The n=
umber of<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 tuples can be more than one if two or more Syst=
em MMUs are controlled<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 by a single device descriptor.<br>
&gt; +- interrupt-parent: The phandle of the interrupt controller of System=
 MMU<br>
&gt; +- interrupts: Tuples of numbers that indicates the interrupt source. =
The<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0number of elements i=
n the tuple is dependent upon<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;interrupt-parent&#39;=
 property. The number of tuples in this property<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 must be the same with &#39=
;reg&#39; property.<br>
&gt; +<br>
&gt; +Optional properties:<br>
&gt; +- mmuname: Strings of the name of System MMU for debugging purpose. T=
he number<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of strings must be the same with t=
he number of tuples in &#39;reg&#39;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0property.<br>
&gt;<br>
&gt; As commented on previous patch, this isn&#39;t something that belongs =
here.<br>
&gt; But for debugging you could probably retrieve this from the node name =
?</p>
<p>Thank you for good idea. However mmuname is an array of strings, actuall=
y. Anyway I agree with your opinion that &#39;mmuname&#39; is not proper pr=
operty of a device node. I will remove it and substitute it with base regis=
ter address of a System MMU.<br>

&gt;<br>
&gt; +- mmu-master: phandle to the device node that owns System MMU. Only t=
he device<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0that is specified whith this prope=
rty can control System MMU with<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IOMMU API.<br>
&gt; +<br>
&gt; +Examples:<br>
&gt; +<br>
&gt; +MFC has 2 System MMUs for each port that MFC is attached. Thus it see=
ms natural<br>
&gt; +to define 2 System MMUs for each port of the MFC:<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-mfc-l {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;m=
fc_l&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11210=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
8 5&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmu-master =3D &lt;=
&amp;mfc&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-mfc-r {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;m=
fc_r&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11200=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
6 2&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmu-master =3D &lt;=
&amp;mfc&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +Actually, MFC device driver requires sub-devices that represents each=
 port and<br>
&gt; +above &#39;mmu-master&#39; properties of sysmmu-mfc-l and sysmmu-mfc-=
r have the phandles<br>
&gt; +to those sub-devices.<br>
&gt;<br>
&gt; I find this sentence really difficult to parse. This documentation sho=
uld talk<br>
&gt; about how the device is designed and represented, rather than about it=
s driver.<br>
&gt;<br>
OK. I will trying to find another expression easy to understand.=C2=A0 Do y=
ou have any suggestion?</p>
<p>&gt; +However, it is also a good idea that treats the above System MMUs =
as one System<br>
&gt; +MMU because those System MMUs are actually required by the MFC device=
:<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-mfc {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;m=
fc_l&quot;, &quot;mfc_r&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11210=
000 0x1000<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x11200000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
8 5<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6 2&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmu-master =3D &lt;=
&amp;mfc&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +If System MMU of MFC is defined like the above, the number of element=
s and the<br>
&gt; +order of list in &#39;mmuname&#39;, &#39;reg&#39; and &#39;interrupts=
&#39; must be the same.<br>
&gt; diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exy=
nos4210.dtsi<br>
&gt; index e31bfc4..1c134b2 100644<br>
&gt; --- a/arch/arm/boot/dts/exynos4210.dtsi<br>
&gt; +++ b/arch/arm/boot/dts/exynos4210.dtsi<br>
&gt; @@ -76,4 +76,100 @@<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x=
100C0000 0x100&gt;;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D=
 &lt;2 4&gt;;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-mfcL {<br>
&gt;<br>
&gt; This capitalization looks weird. How about just making it sysmmu-mfc-l=
 ?<br>
OK. That looks better.<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;m=
fc_l&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x13620=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
5 5&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-mfcR {<br>
&gt;<br>
&gt; and sysmmu-mfc-r ?<br>
&gt;<br>
&gt; Hmm, you actually have it defined this way for exynos5250...<br>
Oh really I did. I will make it better.<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;m=
fc_r&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x13630=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
5 6&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-tv {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;t=
v&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x13E20=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
5 4&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-fimc0 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
imc0&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11A20=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
4 2&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-fimc1 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
imc1&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11A30=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
4 3&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-fimc2 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
imc2&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11A40=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
4 4&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-fimc3 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
imc3&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11A50=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
4 5&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-jpeg {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;j=
peg&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11A60=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
4 6&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-g2d {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;g=
2d&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x12A20=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
4 7&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-rotator {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;r=
otator&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x12A30=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
5 0&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-fimd0 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
imd0&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11E20=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
5 2&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-fimd1 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
imd1&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x12220=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
5 3&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; =C2=A0};<br>
&gt; diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exy=
nos4x12.dtsi<br>
&gt; index 179a62e..0c6d001 100644<br>
&gt; --- a/arch/arm/boot/dts/exynos4x12.dtsi<br>
&gt; +++ b/arch/arm/boot/dts/exynos4x12.dtsi<br>
&gt; @@ -66,4 +66,128 @@<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x=
106E0000 0x1000&gt;;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D=
 &lt;0 72 0&gt;;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-mfcL {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;m=
fc_l&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x13620=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
5 5&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-mfcR {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;m=
fc_r&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x13630=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
5 6&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-tv {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;t=
v&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x13E20=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
5 4&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-fimc0 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
imc0&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11A20=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
4 2&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-fimc1 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
imc1&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11A30=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
4 3&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-fimc2 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
imc2&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11A40=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
4 4&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-fimc3 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
imc3&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11A50=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
4 5&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-jpeg {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;j=
peg&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11A60=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
4 6&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-g2d {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;g=
2d&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x10A40=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
4 7&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-rotator {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;r=
otator&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x12A30=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
5 0&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-fimd0 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
imd0&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11E20=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
5 2&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-is0 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;i=
sp&quot;, &quot;drc&quot;, &quot;fd&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt; 0x1226=
0000 0x1000<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x12270000 0x1000<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x122A0000 0x1000 &gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
 =C2=A016 2<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 16 3<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 16 4 &gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-is1 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;i=
spcpu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x122B0=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
16 5&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-flite0 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
imc-lite0&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x123B0=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
16 0&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-flite1 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
imc-lite1&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x123C0=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
16 1&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; =C2=A0};<br>
&gt; diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exy=
nos5250.dtsi<br>
&gt; index 2e3b6ef..2ff6d78 100644<br>
&gt; --- a/arch/arm/boot/dts/exynos5250.dtsi<br>
&gt; +++ b/arch/arm/boot/dts/exynos5250.dtsi<br>
&gt; @@ -75,7 +75,7 @@<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D=
 &lt;0 42 0&gt;;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt;<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 codec@11000000 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 mfc: codec@11000000 {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D=
 &quot;samsung,mfc-v6&quot;;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x=
11000000 0x10000&gt;;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D=
 &lt;0 96 0&gt;;<br>
&gt; @@ -578,9 +578,152 @@<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D=
 &lt;0 95 0&gt;;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt;<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 mixer {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 mixer: mixer {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D=
 &quot;samsung,exynos5-mixer&quot;;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x=
14450000 0x10000&gt;;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D=
 &lt;0 94 0&gt;;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-mfc-l {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;m=
fc_l&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11210=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
8 5&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmu-master =3D &lt;=
&amp;mfc&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-mfc-r {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;m=
fc_r&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11200=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
6 2&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmu-master =3D &lt;=
&amp;mfc&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-tv {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;t=
v&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x14650=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
7 4&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmu-master =3D &lt;=
&amp;mixer&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-gsc0 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;g=
sc0&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x13E80=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
2 0&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmu-master =3D &lt;=
&amp;gsc_0&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-gsc1 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;g=
sc1&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x13E90=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
2 2&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmu-master =3D &lt;=
&amp;gsc_1&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-gsc2 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;g=
sc2&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x13EA0=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
2 4&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmu-master =3D &lt;=
&amp;gsc_2&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-gsc3 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;g=
sc3&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x13EB0=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
2 6&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmu-master =3D &lt;=
&amp;gsc_3&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-fimd1 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
imd1&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x14640=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
3 2&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-rotator {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;r=
otator&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11D40=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
4 0&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-is0 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;i=
sp&quot;, &quot;drc&quot;, &quot;scalerc&quot;, &quot;scalerp&quot;, &quot;=
fd&quot;, &quot;mcu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt; 0x1326=
0000 0x1000<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x13270000 0x1000<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x13280000 0x1000<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x13290000 0x1000<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x132A0000 0x1000<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x132B0000 0x1000 &gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
 =C2=A010 6<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 11 6<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05 2<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 6<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05 0<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05 4 &gt;;<br>
&gt;<br>
&gt; I believe this should be<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D=
 &lt;10 6&gt;, &lt;11 6&gt;, &lt;5 2&gt;,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;3 6&gt;, &lt;5 0&gt;, &lt;5 4&gt;;<br=
>
&gt;<br>
I found the syntax of array of resources in the specifications of device tr=
ee. I found that it works correctly.<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-is1 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;o=
dc&quot;, &quot;dis0&quot;, &quot;dis1&quot;, &quot;3dnr&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt; 0x132C=
0000 0x1000<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x132D0000 0x1000<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x132E0000 0x1000<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x132F0000 0x1000 &gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
 =C2=A011 0<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10 4<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A09 4<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05 6 &gt;;<br>
&gt;<br>
&gt; Ditto.<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-2d {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;2=
d&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x10A60=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
24 5&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-jpeg {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;j=
peg&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x11F20=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
4 2&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-flite0 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
lite0&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x13C40=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
3 4&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 sysmmu-flite1 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmuname =3D &quot;f=
lite1&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &lt;0x13C50=
000 0x1000&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;samsung,exynos-sysmmu&quot;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt-parent =
=3D &lt;&amp;combiner&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
24 1&gt;;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; =C2=A0};<br>
&gt;<br>
&gt; --<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Sylwester<br>
&gt;<br>
Thank you for kind review.</p>
<p>KyongHo</p>

--f46d044304dc31504704d2b088ec--

--===============7952918516795421659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7952918516795421659==--
