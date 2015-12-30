From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2] iommu/dma: Map scatterlists more parsimoniously
Date: Wed, 30 Dec 2015 09:42:06 +0800
Message-ID: <1451439726.27665.3.camel@mhfsdcap03>
References: <cf89e25139683d85862302e75f9923d101ba233e.1448016328.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6297533530914261196=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cf89e25139683d85862302e75f9923d101ba233e.1448016328.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============6297533530914261196==
Content-Type: multipart/alternative; boundary="=-Rx0Mlvgrn8asgprt0H2u"

--=-Rx0Mlvgrn8asgprt0H2u
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2015-11-20 at 10:57 +0000, Robin Murphy wrote:

> Whilst blindly assuming the worst case for segment boundaries and
> aligning every segment individually is safe from the point of view
> of respecting the device's parameters, it is also undeniably a waste
> of IOVA space. Futhermore, the knock-on effects of more pages than
> necessary being exposed to device access, additional overhead in page
> table updates and TLB invalidations, etc., are even more undesirable.
> 
> Improve matters by taking the actual boundary mask into account to
> actively detect the cases in which we really do need to adjust a
> segment, and avoid wasting space in the remainder.
> 
> Tested-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>


Hi Robin,
    What's the status of this patch? Could we know whether it will be
merged into v4.5?
 

> ---
> 
> Minor change: removed the now-redundant null check on prev, since we no
> longer dereference it unconditionally and pad_len is guaranteed to be
> zero the first time around.
> 
>  drivers/iommu/dma-iommu.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

[...]


--=-Rx0Mlvgrn8asgprt0H2u
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/4.2.2">
</HEAD>
<BODY>
On Fri, 2015-11-20 at 10:57 +0000, Robin Murphy wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
Whilst blindly assuming the worst case for segment boundaries and
aligning every segment individually is safe from the point of view
of respecting the device's parameters, it is also undeniably a waste
of IOVA space. Futhermore, the knock-on effects of more pages than
necessary being exposed to device access, additional overhead in page
table updates and TLB invalidations, etc., are even more undesirable.

Improve matters by taking the actual boundary mask into account to
actively detect the cases in which we really do need to adjust a
segment, and avoid wasting space in the remainder.

Tested-by: Yong Wu &lt;<A HREF="mailto:yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org">yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org</A>&gt;
Signed-off-by: Robin Murphy &lt;<A HREF="mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org">robin.murphy-5wv7dgnIgG8@public.gmane.org</A>&gt;
</PRE>
</BLOCKQUOTE>
<BR>
Hi Robin,<BR>
&nbsp;&nbsp;&nbsp; What's the status of this patch? Could we know whether it will be merged into v4.5?<BR>
 
<BLOCKQUOTE TYPE=CITE>
<PRE>
---

Minor change: removed the now-redundant null check on prev, since we no
longer dereference it unconditionally and pad_len is guaranteed to be
zero the first time around.

 drivers/iommu/dma-iommu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

</PRE>
</BLOCKQUOTE>
[...]<BR>
<BR>
</BODY>
</HTML>

--=-Rx0Mlvgrn8asgprt0H2u--

--===============6297533530914261196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6297533530914261196==--
