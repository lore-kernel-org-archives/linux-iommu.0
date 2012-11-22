From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 02/12] ARM: EXYNOS: Add clk_ops for gating clocks of System
	MMU
Date: Thu, 22 Nov 2012 13:51:51 +0900
Message-ID: <CAHQjnOMSB+0SrNAfrJdXo_MWCHjEULWVzyEejcOWxWeT73sZfg@mail.gmail.com>
References: <002801cdc7a5$8535f6d0$8fa1e470$%cho@samsung.com>
	<50ACF847.3070709@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0391926391929517344=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <50ACF847.3070709-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Subash Patel <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Sanghyun Lee <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============0391926391929517344==
Content-Type: multipart/alternative; boundary=e0cb4efe2dccb725c404cf0e39aa

--e0cb4efe2dccb725c404cf0e39aa
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Nov 22, 2012 at 12:50 AM, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> On 11/21/12 14:03, Cho KyongHo wrote:
>>
>> Touching some System MMU needs its master devices' clock to be enabled
>> before. This commit adds clk_ops.set_parent of gating clocks of System
>> MMU to ensure gating clocks of System MMU's mater devices are enabled
>> when enabling gating clocks of System MMU.
>>
>> Change-Id: Icd58b12f599e92692c032516331a444f4703ba6b
>
>
> Same here, we don't need this :-)
>
>
>> Signed-off-by: KyongHo Cho<pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>>   arch/arm/mach-exynos/clock-exynos5.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>
> Looks good to me, and I think, this can be applied independently from this
> series. Will apply with removing 'Change-Id'.
>
Yes. I missed that.
It will be removed.

Thank you.

Cho KyongHo

--e0cb4efe2dccb725c404cf0e39aa
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2012 at 12:50 AM, Kukjin Kim &lt;<a href=3D"mailto:kgene.ki=
m@samsung.com">kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote:<br>&gt; On 11/21/12 14:=
03, Cho KyongHo wrote:<br>&gt;&gt;<br>&gt;&gt; Touching some System MMU nee=
ds its master devices&#39; clock to be enabled<br>
&gt;&gt; before. This commit adds clk_ops.set_parent of gating clocks of Sy=
stem<br>&gt;&gt; MMU to ensure gating clocks of System MMU&#39;s mater devi=
ces are enabled<br>&gt;&gt; when enabling gating clocks of System MMU.<br>
&gt;&gt;<br>&gt;&gt; Change-Id: Icd58b12f599e92692c032516331a444f4703ba6b<b=
r>&gt;<br>&gt;<br>&gt; Same here, we don&#39;t need this :-)<br>&gt;<br>&gt=
;<br>&gt;&gt; Signed-off-by: KyongHo Cho&lt;<a href=3D"mailto:pullip.cho@sa=
msung.com">pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
&gt;&gt; ---<br>&gt;&gt; =A0 arch/arm/mach-exynos/clock-exynos5.c | 25 ++++=
+++++++++++++++++++++<br>&gt;&gt; =A0 1 file changed, 25 insertions(+)<br>&=
gt;&gt;<br>&gt;<br>&gt; Looks good to me, and I think, this can be applied =
independently from this<br>
&gt; series. Will apply with removing &#39;Change-Id&#39;.<br>&gt;<br>Yes. =
I missed that.<br>It will be removed.<br><br>Thank you.<br><br>Cho KyongHo<=
br>

--e0cb4efe2dccb725c404cf0e39aa--

--===============0391926391929517344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0391926391929517344==--
