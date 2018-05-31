From: Yizhuo Zhai <yzhai003-3vSkeFsW7jA@public.gmane.org>
Subject: [patch] drivers/iommu/amd_iommu.c: argument page_size could be
	uninitialized
Date: Thu, 31 May 2018 11:20:28 -0700
Message-ID: <CABvMjLQL4QXiX+8h3qTSUjD3bD4MU5oAp=PijHh94xnZgVWM7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7306551072548605939=="
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

--===============7306551072548605939==
Content-Type: multipart/alternative; boundary="000000000000a6472c056d84855f"

--000000000000a6472c056d84855f
Content-Type: text/plain; charset="UTF-8"

Argument "page_size" passing to function "fetch_pte" could be uninitialized
if the function returns NULL. The caller "iommu_unmap_page" checks the
return value but the page_size is used outside the if block.

Signed-off-by: yzhai003-3vSkeFsW7jA@public.gmane.org <yzhai003-3vSkeFsW7jA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 774e057..3a23e97 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1397,6 +1397,7 @@ static u64 *fetch_pte(struct protection_domain
*domain,
 {
  int level;
  u64 *pte;
+ *page_size = 0;

  if (address > PM_LEVEL_SIZE(domain->mode))
  return NULL;
-- 
2.7.4
-- 
Kind Regards,

*Yizhuo Zhai*

*Computer Science, Graduate Student*
*University of California, Riverside *

--000000000000a6472c056d84855f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Argument &quot;page_size&quot; passing to function &q=
uot;fetch_pte&quot; could be uninitialized if the function returns NULL. Th=
e caller &quot;iommu_unmap_page&quot; checks the return value but the page_=
size is used outside the if block.</div><div><br></div><div><div>Signed-off=
-by: <a href=3D"mailto:yzhai003-3vSkeFsW7jA@public.gmane.org">yzhai003-3vSkeFsW7jA@public.gmane.org</a> &lt;<a href=
=3D"mailto:yzhai003-3vSkeFsW7jA@public.gmane.org">yzhai003-3vSkeFsW7jA@public.gmane.org</a>&gt;</div><div>---</div><d=
iv>=C2=A0drivers/iommu/amd_iommu.c | 1 +</div><div>=C2=A01 file changed, 1 =
insertion(+)</div><div><br></div><div>diff --git a/drivers/iommu/amd_iommu.=
c b/drivers/iommu/amd_iommu.c</div><div>index 774e057..3a23e97 100644</div>=
<div>--- a/drivers/iommu/amd_iommu.c</div><div>+++ b/drivers/iommu/amd_iomm=
u.c</div><div>@@ -1397,6 +1397,7 @@ static u64 *fetch_pte(struct protection=
_domain *domain,</div><div>=C2=A0{</div><div>=C2=A0<span style=3D"white-spa=
ce:pre">	</span>int level;</div><div>=C2=A0<span style=3D"white-space:pre">=
	</span>u64 *pte;</div><div>+<span style=3D"white-space:pre">	</span>*page_=
size =3D 0;</div><div>=C2=A0</div><div>=C2=A0<span style=3D"white-space:pre=
">	</span>if (address &gt; PM_LEVEL_SIZE(domain-&gt;mode))</div><div>=C2=A0=
<span style=3D"white-space:pre">		</span>return NULL;</div><div>--=C2=A0</d=
iv><div>2.7.4</div></div>-- <br><div class=3D"gmail_signature"><div dir=3D"=
ltr"><span style=3D"font-size:14px">Kind Regards,</span><div style=3D"font-=
size:14px"><br><div><font face=3D"arial, helvetica, sans-serif" size=3D"2">=
<b>Yizhuo Zhai</b></font></div></div><div style=3D"font-size:14px"><br></di=
v><div style=3D"font-size:14px"><b>Computer Science, Graduate Student</b></=
div><div style=3D"font-size:14px"><b>University of California, Riverside=C2=
=A0</b></div></div></div>
</div>

--000000000000a6472c056d84855f--

--===============7306551072548605939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7306551072548605939==--
