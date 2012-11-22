From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 01/12] ARM: EXYNOS: remove system mmu initialization from
	exynos tree
Date: Thu, 22 Nov 2012 13:52:03 +0900
Message-ID: <CAHQjnONNpk_jKtN3J38-t6hRwfq6LCyqwr=U8dwSKoQ+KcpZvA@mail.gmail.com>
References: <002701cdc7a5$756dbdf0$604939d0$%cho@samsung.com>
	<50ACF755.9000706@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2363609560631899472=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <50ACF755.9000706-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
Cc: "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Subash Patel <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sanghyun Lee <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============2363609560631899472==
Content-Type: multipart/alternative; boundary=e0cb4efe351c7353b304cf0e3ac9

--e0cb4efe351c7353b304cf0e3ac9
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Nov 22, 2012 at 12:46 AM, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> On 11/21/12 14:02, Cho KyongHo wrote:
>>
>> This removes System MMU initialization from arch/arm/mach-exynos/
>
>
> Basically, looks OK to me, but I think, this removing change should be
done
> after 03/12 patch :-)
>
Thank you. I agree.
It will be moved to 03/12 patch as you mentioned.

>> to move them to DT and the exynos-iommu driver except gating clock
>> definitions.
>>
>> Change-Id: Ie29f587c01c645f28fc0e0b94eb3631a0170ebf5
>
>
> No need 'Change-Id' here.
>
That is my fault. It will be removed.

Thank you.

Cho KyongHo.

--e0cb4efe351c7353b304cf0e3ac9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>On Thu, Nov 22, 2012 at 12:46 AM, Kukjin Kim &lt;<a href=3D"mailto:kgen=
e.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote:<br>&gt; On 11/21/12=
 14:02, Cho KyongHo wrote:<br>&gt;&gt;<br>&gt;&gt; This removes System MMU =
initialization from arch/arm/mach-exynos/<br>
&gt;<br>&gt;<br>&gt; Basically, looks OK to me, but I think, this removing =
change should be done<br>&gt; after 03/12 patch :-)<br>&gt;<br>Thank you. I=
 agree.<br>It will be moved to 03/12 patch as you mentioned.<br><br>&gt;&gt=
; to move them to DT and the exynos-iommu driver except gating clock<br>
&gt;&gt; definitions.<br>&gt;&gt;<br>&gt;&gt; Change-Id: Ie29f587c01c645f28=
fc0e0b94eb3631a0170ebf5<br>&gt;<br>&gt;<br>&gt; No need &#39;Change-Id&#39;=
 here.<br>&gt;<br>That is my fault. It will be removed.<br><br>Thank you.<b=
r>
<br>Cho KyongHo.<br>

--e0cb4efe351c7353b304cf0e3ac9--

--===============2363609560631899472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2363609560631899472==--
