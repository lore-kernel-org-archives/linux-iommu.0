From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [Patch Part1 V2 07/20] iommu/vt-d, trivial: check suitable flag
	in function detect_intel_iommu()
Date: Mon, 06 Jan 2014 13:52:17 +0800
Message-ID: <52CA4491.6020009@linux.intel.com>
References: <1386300083-6882-1-git-send-email-jiang.liu@linux.intel.com>	<1386300083-6882-8-git-send-email-jiang.liu@linux.intel.com>
	<CAOtp4KqnHTk0qh_h76y3z3EGJSax3QtsSS3SBPRNEjbAaBCTZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6560950962842730092=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAOtp4KqnHTk0qh_h76y3z3EGJSax3QtsSS3SBPRNEjbAaBCTZg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kai Huang <dev.kai.huang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This is a multi-part message in MIME format.
--===============6560950962842730092==
Content-Type: multipart/alternative;
 boundary="------------010107020308070504060302"

This is a multi-part message in MIME format.
--------------010107020308070504060302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


> On Fri, Dec 6, 2013 at 11:21 AM, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
> <mailto:jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>> wrote:
>
>     Flag irq_remapping_enabled is only set by
>     intel_enable_irq_remapping(),
>     which is called after detect_intel_iommu(). So we should check flag
>     disable_irq_remap instead of irq_remapping_enabled in function
>     detect_intel_iommu().
>
>     Reviewed-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
>     <mailto:wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>>
>     Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
>     <mailto:jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>>
>     ---
>      drivers/iommu/dmar.c |    2 +-
>      1 file changed, 1 insertion(+), 1 deletion(-)
>
>     diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
>     index c17dbf7..70612a9 100644
>     --- a/drivers/iommu/dmar.c
>     +++ b/drivers/iommu/dmar.c
>     @@ -560,7 +560,7 @@ int __init detect_intel_iommu(void)
>
>                     dmar = (struct acpi_table_dmar *) dmar_tbl;
>
>     -               if (ret && irq_remapping_enabled && cpu_has_x2apic &&
>     +               if (ret && !disable_irq_remap && cpu_has_x2apic &&
>                         dmar->flags & 0x1)
>                             pr_info("Queued invalidation will be
>     enabled to support x2apic and Intr-remapping.\n");
>
>
> Then is it better to move this pr_info code
> to intel_enable_irq_remapping?
Hi Kai,
    Good suggestion! Will try it.
Thanks!
Gerry

>
>
>     --
>     1.7.10.4
>
>     --
>     To unsubscribe from this list: send the line "unsubscribe
>     linux-pci" in
>     the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>     <mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>     More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


--------------010107020308070504060302
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <blockquote
cite="mid:CAOtp4KqnHTk0qh_h76y3z3EGJSax3QtsSS3SBPRNEjbAaBCTZg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
      type="cite">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">On Fri, Dec 6, 2013 at 11:21 AM,
            Jiang Liu <span dir="ltr">&lt;<a moz-do-not-send="true"
                href="mailto:jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" target="_blank">jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">Flag
              irq_remapping_enabled is only set by
              intel_enable_irq_remapping(),<br>
              which is called after detect_intel_iommu(). So we should
              check flag<br>
              disable_irq_remap instead of irq_remapping_enabled in
              function<br>
              detect_intel_iommu().<br>
              <br>
              Reviewed-by: Yijing Wang &lt;<a moz-do-not-send="true"
                href="mailto:wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org">wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org</a>&gt;<br>
              Signed-off-by: Jiang Liu &lt;<a moz-do-not-send="true"
                href="mailto:jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org">jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org</a>&gt;<br>
              ---<br>
              &nbsp;drivers/iommu/dmar.c | &nbsp; &nbsp;2 +-<br>
              &nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
              <br>
              diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c<br>
              index c17dbf7..70612a9 100644<br>
              --- a/drivers/iommu/dmar.c<br>
              +++ b/drivers/iommu/dmar.c<br>
              @@ -560,7 +560,7 @@ int __init detect_intel_iommu(void)<br>
              <br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dmar = (struct acpi_table_dmar *)
              dmar_tbl;<br>
              <br>
              - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ret &amp;&amp; irq_remapping_enabled
              &amp;&amp; cpu_has_x2apic &amp;&amp;<br>
              + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ret &amp;&amp; !disable_irq_remap
              &amp;&amp; cpu_has_x2apic &amp;&amp;<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dmar-&gt;flags &amp; 0x1)<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pr_info("Queued invalidation will
              be enabled to support x2apic and Intr-remapping.\n");<br>
            </blockquote>
            <div><br>
            </div>
            <div>Then is it better to move this pr_info code to&nbsp;<span
                style="font-family:arial,sans-serif;font-size:13px">intel_enable_irq_remapping?
                <br>
              </span></div>
          </div>
        </div>
      </div>
    </blockquote>
    Hi Kai,<br>
    &nbsp;&nbsp;&nbsp; Good suggestion! Will try it.<br>
    Thanks!<br>
    Gerry<br>
    <br>
    <blockquote
cite="mid:CAOtp4KqnHTk0qh_h76y3z3EGJSax3QtsSS3SBPRNEjbAaBCTZg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
      type="cite">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">
            <div><br>
            </div>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><span
                class=""><font color="#888888"><br>
                  --<br>
                  1.7.10.4<br>
                  <br>
                  --<br>
                  To unsubscribe from this list: send the line
                  "unsubscribe linux-pci" in<br>
                  the body of a message to <a moz-do-not-send="true"
                    href="mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
                  More majordomo info at &nbsp;<a moz-do-not-send="true"
                    href="http://vger.kernel.org/majordomo-info.html"
                    target="_blank">http://vger.kernel.org/majordomo-info.html</a><br>
                </font></span></blockquote>
          </div>
          <br>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------010107020308070504060302--

--===============6560950962842730092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6560950962842730092==--
