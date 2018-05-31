From: Yizhuo Zhai <yzhai003-3vSkeFsW7jA@public.gmane.org>
Subject: [patch] /drivers/iommu/amd_iommu.c: variable unmap_size could be
	uninitialized
Date: Wed, 30 May 2018 23:02:54 -0700
Message-ID: <CABvMjLS3xMmMCSk4Y9Q1rd3398B4kqRi69mn7igPzx6Kt=83cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6530009163052739936=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Chengyu Song <csong-OqvYMq7jYtE3uPMLIKxrzw@public.gmane.org>, Zhiyun Qian <zhiyunq-OqvYMq7jYtE3uPMLIKxrzw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============6530009163052739936==
Content-Type: multipart/alternative; boundary="000000000000e8f846056d7a37f3"

--000000000000e8f846056d7a37f3
Content-Type: text/plain; charset="UTF-8"

Variable "unmap_size" is supposed to be initialized in function fetch_pte.
However, it's uninitialized if fetch_pte returns NULL. And "unmap_size" is
used outside the return check.

>From 377ccb647d3c6c6747f20a242b035bafc775c3be Mon Sep 17 00:00:00 2001

Signed-off-by: From: "yzhai003-3vSkeFsW7jA@public.gmane.org" <yzhai003-3vSkeFsW7jA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8fb8c73..774e057 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1500,7 +1500,7 @@ static unsigned long iommu_unmap_page(struct
protection_domain *dom,
       unsigned long page_size)
 {
  unsigned long long unmapped;
- unsigned long unmap_size;
+ unsigned long unmap_size = 0;
  u64 *pte;

  BUG_ON(!is_power_of_2(page_size));
-- 
2.7.4


-- 
Kind Regards,

*Yizhuo Zhai*

*Computer Science, Graduate Student*
*University of California, Riverside *

--000000000000e8f846056d7a37f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Variable &quot;unmap_size&quot; is supposed to be ini=
tialized in function fetch_pte. However, it&#39;s uninitialized if fetch_pt=
e returns NULL. And &quot;unmap_size&quot; is used outside the return check=
.=C2=A0</div><div><br></div><div><div>From 377ccb647d3c6c6747f20a242b035baf=
c775c3be Mon Sep 17 00:00:00 2001</div><div><br></div><div>Signed-off-by: F=
rom: &quot;<a href=3D"mailto:yzhai003-3vSkeFsW7jA@public.gmane.org">yzhai003-3vSkeFsW7jA@public.gmane.org</a>&quot; &=
lt;<a href=3D"mailto:yzhai003-3vSkeFsW7jA@public.gmane.org">yzhai003-3vSkeFsW7jA@public.gmane.org</a>&gt;</div><div>-=
--</div><div>=C2=A0drivers/iommu/amd_iommu.c | 2 +-</div><div>=C2=A01 file =
changed, 1 insertion(+), 1 deletion(-)</div><div><br></div><div>diff --git =
a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c</div><div>index 8fb=
8c73..774e057 100644</div><div>--- a/drivers/iommu/amd_iommu.c</div><div>++=
+ b/drivers/iommu/amd_iommu.c</div><div>@@ -1500,7 +1500,7 @@ static unsign=
ed long iommu_unmap_page(struct protection_domain *dom,</div><div>=C2=A0<sp=
an class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">				</span> =C2=
=A0 =C2=A0 =C2=A0unsigned long page_size)</div><div>=C2=A0{</div><div>=C2=
=A0<span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</span>u=
nsigned long long unmapped;</div><div>-<span class=3D"gmail-Apple-tab-span"=
 style=3D"white-space:pre">	</span>unsigned long unmap_size;</div><div>+<sp=
an class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</span>unsigne=
d long unmap_size =3D 0;</div><div>=C2=A0<span class=3D"gmail-Apple-tab-spa=
n" style=3D"white-space:pre">	</span>u64 *pte;</div><div>=C2=A0</div><div>=
=C2=A0<span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</spa=
n>BUG_ON(!is_power_of_2(page_size));</div><div>--=C2=A0</div><div>2.7.4</di=
v><div><br></div></div><div><br></div>-- <br><div class=3D"gmail-m_84048672=
09400713885gmail_signature"><div dir=3D"ltr"><span style=3D"font-size:14px"=
>Kind Regards,</span><div style=3D"font-size:14px"><br><div><font face=3D"a=
rial, helvetica, sans-serif" size=3D"2"><b>Yizhuo Zhai</b></font></div></di=
v><div style=3D"font-size:14px"><br></div><div style=3D"font-size:14px"><b>=
Computer Science, Graduate Student</b></div><div style=3D"font-size:14px"><=
b>University of California, Riverside=C2=A0</b></div></div></div>
</div>

--000000000000e8f846056d7a37f3--

--===============6530009163052739936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6530009163052739936==--
