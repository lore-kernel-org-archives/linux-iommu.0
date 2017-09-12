From: Vinod Adhikary <vinadhy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Use raw_cpu_ptr() instead of get_cpu_ptr() for
	->flush_queue
Date: Mon, 11 Sep 2017 22:22:11 -0400
Message-ID: <CABp9dQUcXTAX9ggX+TAMHE2oH0SF8bcu47E=UYG9fgJdKBXEVg@mail.gmail.com>
References: <20170906103459.oi2nn7jondjqdo5m@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1189220482046980367=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170906103459.oi2nn7jondjqdo5m-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============1189220482046980367==
Content-Type: multipart/alternative; boundary="94eb2c1b7600fd2a0b0558f4b53b"

--94eb2c1b7600fd2a0b0558f4b53b
Content-Type: text/plain; charset="UTF-8"

Dear all,

Thank you for the great community support and support from Sebastian to
provide me this patch. I wanted to send this email to inform you and
perhaps get some information on how I could keep myself updated on updates
in regards to linux-rt. I apologize if I'm spamming you with this email.

I noticed `Bug: Scheduling while atomic` on ahci after building 4.9 rt and
reported the issue on oftc channel. Sebastian quickly helped me get a patch
and my `journalctl -f` was clean without any such messages. Yesterday I
decided to build 4.11 without the patch but I saw a whole bunch of similar
bug logs not just on ahci but on my nic card as well among a few others.
There were a few instances where I had to hard shutdown my machine. I
patched 4.11 with Sebastian's patch again and so far it's been okay for
about 24 hours and going.

My concern is, how I can provide more information to resolve this issue,
perhaps in the next release. Please let me know how I can be of help.

Thank you

On Wed, Sep 6, 2017 at 6:34 AM, Sebastian Andrzej Siewior <
bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:

> get_cpu_ptr() disables preemption and returns the ->flush_queue object
> of the current CPU. raw_cpu_ptr() does the same except that it not
> disable preemption which means the scheduler can move it to another CPU
> after it obtained the per-CPU object.
> In this case this is not bad because the data structure itself is
> protected with a spin_lock. This change shouldn't matter in general
> but on RT it does because the sleeping lock can't be accessed with
> disabled preemption.
>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Reported-by: vinadhy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 4ad7e5e31943..943efbc08128 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1911,7 +1911,7 @@ static void queue_add(struct dma_ops_domain *dom,
>         pages     = __roundup_pow_of_two(pages);
>         address >>= PAGE_SHIFT;
>
> -       queue = get_cpu_ptr(dom->flush_queue);
> +       queue = raw_cpu_ptr(dom->flush_queue);
>         spin_lock_irqsave(&queue->lock, flags);
>
>         /*
> @@ -1940,8 +1940,6 @@ static void queue_add(struct dma_ops_domain *dom,
>
>         if (atomic_cmpxchg(&dom->flush_timer_on, 0, 1) == 0)
>                 mod_timer(&dom->flush_timer, jiffies +
> msecs_to_jiffies(10));
> -
> -       put_cpu_ptr(dom->flush_queue);
>  }
>
>  static void queue_flush_timeout(unsigned long data)
> --
> 2.14.1
>
>

--94eb2c1b7600fd2a0b0558f4b53b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Dear all, <br><br></div>Thank you for the great =
community support and support from Sebastian to provide me this patch. I wa=
nted to send this email to inform you and perhaps get some information on h=
ow I could keep myself updated on updates in regards to linux-rt. I apologi=
ze if I&#39;m spamming you with this email. <br></div><div><br></div><div>I=
 noticed `Bug: Scheduling while atomic` on ahci after building 4.9 rt and r=
eported the issue on oftc channel. Sebastian quickly helped me get a patch =
and my `journalctl -f` was clean without any such messages. Yesterday I dec=
ided to build 4.11 without the patch but I saw a whole bunch of similar bug=
 logs not just on ahci but on my nic card as well among a few others. There=
 were a few instances where I had to hard shutdown my machine. I patched 4.=
11 with Sebastian&#39;s patch again and so far it&#39;s been okay for about=
 24 hours and going.<br></div><div><br></div><div>My concern is, how I can =
provide more information to resolve this issue, perhaps in the next release=
. Please let me know how I can be of help.</div><div><br></div><div>Thank y=
ou</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On =
Wed, Sep 6, 2017 at 6:34 AM, Sebastian Andrzej Siewior <span dir=3D"ltr">&l=
t;<a href=3D"mailto:bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" target=3D"_blank">bigeasy@linutr=
onix.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">get_cpu_ptr=
() disables preemption and returns the -&gt;flush_queue object<br>
of the current CPU. raw_cpu_ptr() does the same except that it not<br>
disable preemption which means the scheduler can move it to another CPU<br>
after it obtained the per-CPU object.<br>
In this case this is not bad because the data structure itself is<br>
protected with a spin_lock. This change shouldn&#39;t matter in general<br>
but on RT it does because the sleeping lock can&#39;t be accessed with<br>
disabled preemption.<br>
<br>
Cc: Joerg Roedel &lt;<a href=3D"mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org">joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org</a>=
&gt;<br>
Cc: <a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu-cunTk1MwBs9IKTv4iemRRA@public.gmane.org=
oundation.<wbr>org</a><br>
Reported-by: <a href=3D"mailto:vinadhy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">vinadhy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a><br>
Signed-off-by: Sebastian Andrzej Siewior &lt;<a href=3D"mailto:bigeasy@linu=
tronix.de">bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/iommu/amd_iommu.c | 4 +---<br>
=C2=A01 file changed, 1 insertion(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c<br>
index 4ad7e5e31943..943efbc08128 100644<br>
--- a/drivers/iommu/amd_iommu.c<br>
+++ b/drivers/iommu/amd_iommu.c<br>
@@ -1911,7 +1911,7 @@ static void queue_add(struct dma_ops_domain *dom,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pages=C2=A0 =C2=A0 =C2=A0=3D __roundup_pow_of_t=
wo(pages);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 address &gt;&gt;=3D PAGE_SHIFT;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0queue =3D get_cpu_ptr(dom-&gt;flush_queue);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0queue =3D raw_cpu_ptr(dom-&gt;flush_queue);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&amp;queue-&gt;<wbr>lock, fla=
gs);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
@@ -1940,8 +1940,6 @@ static void queue_add(struct dma_ops_domain *dom,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (atomic_cmpxchg(&amp;dom-&gt;flush_<wbr>time=
r_on, 0, 1) =3D=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mod_timer(&amp;dom-=
&gt;flush_timer, jiffies + msecs_to_jiffies(10));<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0put_cpu_ptr(dom-&gt;flush_queue);<br>
=C2=A0}<br>
<br>
=C2=A0static void queue_flush_timeout(unsigned long data)<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.14.1<br>
<br>
</font></span></blockquote></div><br></div>

--94eb2c1b7600fd2a0b0558f4b53b--

--===============1189220482046980367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1189220482046980367==--
