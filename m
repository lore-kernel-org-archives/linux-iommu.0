From: "Shankar, Hari" <Hari.Shankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] On unmap, flush IOMMU TLB and return correct size
Date: Mon, 2 Sep 2013 02:24:20 +0000
Message-ID: <CE494510.41547%hshankar@netapp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5555623574710580053=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "Singh, Varinder" <Varinder.Singh-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Sundaram,
	Rajesh" <Rajesh.Sundaram-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Kimmel,
	Jeff" <jeff.kimmel-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Spiller, John" <John.Spiller-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============5555623574710580053==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CE49451041547hshankarnetappcom_"

--_000_CE49451041547hshankarnetappcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Patch Description: The patch is for Intel IOMMU driver. It forces IOMMU TLB=
 flush for the particular domain and return correct unmap size when intel_i=
ommu_unmap() is called

The patch is generated on Linux kernel version 3.6.11

--- linux/drivers/iommu/intel-iommu.c.orig      2013-09-01 10:10:14.7239580=
00 -0700
+++ linux/drivers/iommu/intel-iommu.c   2013-09-01 18:22:58.497578000 -0700
@@ -4060,14 +4060,31 @@ static size_t intel_iommu_unmap(struct i
 {
        struct dmar_domain *dmar_domain =3D domain->priv;
        int order;
+       struct intel_iommu *iommu;
+       unsigned long start_pfn, last_pfn;
+       unsigned int npages;
+       int iommu_id, num, ndomains;

-       order =3D dma_pte_clear_range(dmar_domain, iova >> VTD_PAGE_SHIFT,
-                           (iova + size - 1) >> VTD_PAGE_SHIFT);
+       start_pfn =3D iova >> VTD_PAGE_SHIFT;
+       last_pfn =3D (iova + size - 1) >> VTD_PAGE_SHIFT;
+       order =3D dma_pte_clear_range(dmar_domain, start_pfn, last_pfn);
+       last_pfn |=3D (1UL << order) - 1;
+       npages =3D last_pfn - start_pfn + 1;
+       for_each_set_bit(iommu_id, dmar_domain->iommu_bmp, g_num_of_iommus)=
 {
+               iommu =3D g_iommus[iommu_id];

-       if (dmar_domain->max_addr =3D=3D iova + size)
+               /*
+                * find bit position of dmar_domain
+                */
+               ndomains =3D cap_ndoms(iommu->cap);
+               for_each_set_bit(num, iommu->domain_ids, ndomains)
+                       if (iommu->domains[num] =3D=3D dmar_domain)
+                               iommu_flush_iotlb_psi(iommu, num,
+                                                       start_pfn, npages, =
0);
+       }
+       if (dmar_domain->max_addr <=3D iova + (npages << VTD_PAGE_SHIFT))
                dmar_domain->max_addr =3D iova;
-
-       return PAGE_SIZE << order;
+       return npages << VTD_PAGE_SHIFT;
 }

 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,

Signed-off-by: Hari Shankar <hshankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--_000_CE49451041547hshankarnetappcom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <2CAC1C3F89237E42B269A332586949D2-c5HhxtLuC0z3oGB3hsPCZA@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space; font-family: Calibri, sans-serif; font-size: 14=
px; color: rgb(0, 0, 0); ">
<div>Patch Description: The patch is for&nbsp;Intel IOMMU driver. It&nbsp;f=
orces IOMMU TLB flush for the particular domain and return correct unmap si=
ze when intel_iommu_unmap() is called</div>
<div></div>
<div><br>
</div>
<div>The patch is generated on Linux kernel version 3.6.11</div>
<div><br>
</div>
<div>
<div>--- linux/drivers/iommu/intel-iommu.c.orig &nbsp; &nbsp; &nbsp;2013-09=
-01 10:10:14.723958000 -0700</div>
<div>&#43;&#43;&#43; linux/drivers/iommu/intel-iommu.c &nbsp; 2013-09-01 18=
:22:58.497578000 -0700</div>
<div>@@ -4060,14 &#43;4060,31 @@ static size_t intel_iommu_unmap(struct i</=
div>
<div>&nbsp;{</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; struct dmar_domain *dmar_domain =3D domain=
-&gt;priv;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; int order;</div>
<div>&#43; &nbsp; &nbsp; &nbsp; struct intel_iommu *iommu;</div>
<div>&#43; &nbsp; &nbsp; &nbsp; unsigned long start_pfn, last_pfn;</div>
<div>&#43; &nbsp; &nbsp; &nbsp; unsigned int npages;</div>
<div>&#43; &nbsp; &nbsp; &nbsp; int iommu_id, num, ndomains;</div>
<div><br>
</div>
<div>- &nbsp; &nbsp; &nbsp; order =3D dma_pte_clear_range(dmar_domain, iova=
 &gt;&gt; VTD_PAGE_SHIFT,</div>
<div>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; (iova &#43; size - 1) &gt;&gt; VTD_PAGE_SHIFT);</div=
>
<div>&#43; &nbsp; &nbsp; &nbsp; start_pfn =3D iova &gt;&gt; VTD_PAGE_SHIFT;=
</div>
<div>&#43; &nbsp; &nbsp; &nbsp; last_pfn =3D (iova &#43; size - 1) &gt;&gt;=
 VTD_PAGE_SHIFT;</div>
<div>&#43; &nbsp; &nbsp; &nbsp; order =3D dma_pte_clear_range(dmar_domain, =
start_pfn, last_pfn);</div>
<div>&#43; &nbsp; &nbsp; &nbsp; last_pfn |=3D (1UL &lt;&lt; order) - 1;</di=
v>
<div>&#43; &nbsp; &nbsp; &nbsp; npages =3D last_pfn - start_pfn &#43; 1;</d=
iv>
<div>&#43; &nbsp; &nbsp; &nbsp; for_each_set_bit(iommu_id, dmar_domain-&gt;=
iommu_bmp, g_num_of_iommus) {</div>
<div>&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; iommu =3D g_iom=
mus[iommu_id];</div>
<div><br>
</div>
<div>- &nbsp; &nbsp; &nbsp; if (dmar_domain-&gt;max_addr =3D=3D iova &#43; =
size)</div>
<div>&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*</div>
<div>&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* find bi=
t position of dmar_domain</div>
<div>&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/</div>
<div>&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ndomains =3D ca=
p_ndoms(iommu-&gt;cap);</div>
<div>&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for_each_set_bi=
t(num, iommu-&gt;domain_ids, ndomains)</div>
<div>&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; if (iommu-&gt;domains[num] =3D=3D dmar_domain)</div>
<div>&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; iommu_flush_iotlb_psi(iommu, num,<=
/div>
<div>&#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; start_pfn, npages, 0);</d=
iv>
<div>&#43; &nbsp; &nbsp; &nbsp; }</div>
<div>&#43; &nbsp; &nbsp; &nbsp; if (dmar_domain-&gt;max_addr &lt;=3D iova &=
#43; (npages &lt;&lt; VTD_PAGE_SHIFT))</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dmar_domain-&g=
t;max_addr =3D iova;</div>
<div>-</div>
<div>- &nbsp; &nbsp; &nbsp; return PAGE_SIZE &lt;&lt; order;</div>
<div>&#43; &nbsp; &nbsp; &nbsp; return npages &lt;&lt; VTD_PAGE_SHIFT;</div=
>
<div>&nbsp;}</div>
<div><br>
</div>
<div>&nbsp;static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain =
*domain,</div>
<div><br>
</div>
<div>Signed-off-by: Hari Shankar &lt;hshankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org&gt;</div>
<div>cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</div>
</div>
<div></div>
</body>
</html>

--_000_CE49451041547hshankarnetappcom_--

--===============5555623574710580053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5555623574710580053==--
