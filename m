From: James Dong via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Handle hotplug devices' default identity
	mapping setting
Date: Thu, 21 Feb 2019 22:38:55 -0800
Message-ID: <CADcZez2q7aUL=ahHSGnfO2QDjKL052AePd=TsxkCK-O7EcW77Q@mail.gmail.com>
References: <20190222024455.20802-1-xmdong@google.com>
	<cf965dec-1bae-1d98-e97c-6a84c0c9862f@linux.intel.com>
	<fe6dcb4e-03c4-0bbf-c51f-5964b20593dd@linux.intel.com>
Reply-To: James Dong <xmdong-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4687220231741463976=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <fe6dcb4e-03c4-0bbf-c51f-5964b20593dd-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: James Dong <xmdong-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jis Ben <jisben-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============4687220231741463976==
Content-Type: multipart/alternative; boundary="000000000000f11097058275d885"

--000000000000f11097058275d885
Content-Type: text/plain; charset="UTF-8"

Baolu:

Thanks for your comments and your patch. Please find below our responses to
each of your comments:

> What does "I/O operation won't work" exactly mean here? Do you see any
> IOMMU fault message? Or, something doesn't work as expected?

Yes, DMAR fault messages as following came out:
[  354.939896] DMAR: DMAR:[DMA Read] Request device [03:00.1]fault addr
1fdfe80000
[  354.939896] DMAR:[fault reason 02] Present bit in context entry is clear


> Do you mind checking this?
>
> index 6ecdcf8fc8c0..f62f30bc1339 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2632,6 +2632,9 @@ static struct dmar_domain
> *find_or_alloc_domain(struct device *dev, int gaw)
>                          goto out;
>          }
>
> +       if (!iommu_should_identity_map(dev, 0))
> +               return si_domain;
> +
>          /* Allocate and initialize new domain for the device */
>          domain = alloc_domain(0);
>          if (!domain)

Tried this patch, and the same DMAR fault message came out.

Guess it is because of the iommu code path for hotplug devices. If a hotplug
device is rescanned after removal, iommu_bus_notifier will be called as part
of the notifier chains to handle BUS_NOTIFY_ADD_DEVICE event. Along the code
path, intel_iommu_ops->add_device() created an iommu group for this hotplug
device, but failed to create an iommu domain because of the default domain
type IOMMU_DOMAIN_IDENTITY imposed by current IOMMU command line option got
declined by intel_iommu_ops->domain_alloc().

In your patch, function find_or_alloc_domain() is not even in the code path
of BUS_NOTIFY_ADD_DEVICE event notifier chain.

Please let us know if your have more concerns and suggestions.

Best Regards,
James

On Thu, Feb 21, 2019 at 9:35 PM Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> Hi
>
> On 2/22/19 1:06 PM, Lu Baolu wrote:
>
> > Do you mind checking this?
> >
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 6ecdcf8fc8c0..f62f30bc1339 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -2632,6 +2632,9 @@ static struct dmar_domain
> > *find_or_alloc_domain(struct device *dev, int gaw)
> >                          goto out;
> >          }
> >
> > +       if (!iommu_should_identity_map(dev, 0))
> > +               return si_domain;
> > +
> >          /* Allocate and initialize new domain for the device */
> >          domain = alloc_domain(0);
> >          if (!domain)
>
> Oops! This can't be compiled. Please try below instead if you'd like to.
> Sorry about it.
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6ecdcf8fc8c0..b89f5ba6a3c8 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -174,6 +174,8 @@ static inline unsigned long virt_to_dma_pfn(void *p)
>          return page_to_dma_pfn(virt_to_page(p));
>   }
>
> +static int iommu_should_identity_map(struct device *dev, int startup);
> +
>   /* global iommu list, set NULL for ignored DMAR units */
>   static struct intel_iommu **g_iommus;
>
> @@ -2632,6 +2634,9 @@ static struct dmar_domain
> *find_or_alloc_domain(struct device *dev, int gaw)
>                          goto out;
>          }
>
> +       if (iommu_should_identity_map(dev, 0))
> +               return si_domain;
> +
>          /* Allocate and initialize new domain for the device */
>          domain = alloc_domain(0);
>          if (!domain)
>
> Best regards,
> Lu Baolu
>
>
>

--000000000000f11097058275d885
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Baolu:<=
/div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Thanks for your comments a=
nd your patch. Please find below our responses to</div><div dir=3D"ltr">eac=
h of your comments:</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">&gt; W=
hat does &quot;I/O operation won&#39;t work&quot; exactly mean here? Do you=
 see any</div><div dir=3D"ltr">&gt; IOMMU fault message? Or, something does=
n&#39;t work as expected?</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">=
Yes, DMAR fault messages as following came out:</div><div dir=3D"ltr">[=C2=
=A0 354.939896] DMAR: DMAR:[DMA Read] Request device [03:00.1]fault addr 1f=
dfe80000=C2=A0</div><div dir=3D"ltr">[=C2=A0 354.939896] DMAR:[fault reason=
 02] Present bit in context entry is clear</div><div dir=3D"ltr"><br></div>=
<div dir=3D"ltr"><br></div><div dir=3D"ltr">&gt; Do you mind checking this?=
</div><div dir=3D"ltr">&gt;</div><div dir=3D"ltr">&gt; index 6ecdcf8fc8c0..=
f62f30bc1339 100644</div><div dir=3D"ltr">&gt; --- a/drivers/iommu/intel-io=
mmu.c</div><div dir=3D"ltr">&gt; +++ b/drivers/iommu/intel-iommu.c</div><di=
v dir=3D"ltr">&gt; @@ -2632,6 +2632,9 @@ static struct dmar_domain=C2=A0</d=
iv><div dir=3D"ltr">&gt; *find_or_alloc_domain(struct device *dev, int gaw)=
</div><div dir=3D"ltr">&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;</div><div dir=3D"ltr">=
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div dir=3D"ltr">&gt;=C2=A0</=
div><div dir=3D"ltr">&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!iommu_should_ide=
ntity_map(dev, 0))</div><div dir=3D"ltr">&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return si_domain;</div><div dir=3D"ltr">&gt; +</=
div><div dir=3D"ltr">&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Allocate and=
 initialize new domain for the device */</div><div dir=3D"ltr">&gt;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 domain =3D alloc_domain(0);</div><div dir=3D"lt=
r">&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!domain)</div><div dir=3D"ltr=
"><br></div><div dir=3D"ltr">Tried this patch, and the same DMAR fault mess=
age came out.</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Guess it is =
because of the iommu code path for hotplug devices. If a hotplug</div><div =
dir=3D"ltr">device is rescanned after removal, iommu_bus_notifier will be c=
alled as part</div><div dir=3D"ltr">of the notifier chains to handle BUS_NO=
TIFY_ADD_DEVICE event. Along the code</div><div dir=3D"ltr">path, intel_iom=
mu_ops-&gt;add_device() created an iommu group for this hotplug</div><div d=
ir=3D"ltr">device, but failed to create an iommu domain because of the defa=
ult domain=C2=A0</div><div dir=3D"ltr">type IOMMU_DOMAIN_IDENTITY imposed b=
y current IOMMU command line option got</div><div dir=3D"ltr">declined by i=
ntel_iommu_ops-&gt;domain_alloc().</div><div dir=3D"ltr"><br></div><div dir=
=3D"ltr">In your patch, function find_or_alloc_domain() is not even in the =
code path</div><div dir=3D"ltr">of BUS_NOTIFY_ADD_DEVICE event notifier cha=
in.</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Please let us know if =
your have more concerns and suggestions.</div><div dir=3D"ltr"><br></div><d=
iv dir=3D"ltr">Best Regards,</div><div dir=3D"ltr">James</div></div></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Thu, Feb 21, 2019 at 9:35 PM Lu Baolu &lt;<a href=3D"mailto:baolu.lu@linu=
x.intel.com">baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi<br>
<br>
On 2/22/19 1:06 PM, Lu Baolu wrote:<br>
<br>
&gt; Do you mind checking this?<br>
&gt; <br>
&gt; diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c=
<br>
&gt; index 6ecdcf8fc8c0..f62f30bc1339 100644<br>
&gt; --- a/drivers/iommu/intel-iommu.c<br>
&gt; +++ b/drivers/iommu/intel-iommu.c<br>
&gt; @@ -2632,6 +2632,9 @@ static struct dmar_domain <br>
&gt; *find_or_alloc_domain(struct device *dev, int gaw)<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 goto out;<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt; <br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!iommu_should_identity_map(d=
ev, 0))<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return si_domain;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Allocate and initi=
alize new domain for the device */<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 domain =3D alloc_doma=
in(0);<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!domain)<br>
<br>
Oops! This can&#39;t be compiled. Please try below instead if you&#39;d lik=
e to.<br>
Sorry about it.<br>
<br>
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c<br>
index 6ecdcf8fc8c0..b89f5ba6a3c8 100644<br>
--- a/drivers/iommu/intel-iommu.c<br>
+++ b/drivers/iommu/intel-iommu.c<br>
@@ -174,6 +174,8 @@ static inline unsigned long virt_to_dma_pfn(void *p)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return page_to_dma_pfn(virt_to_page(p));<=
br>
=C2=A0 }<br>
<br>
+static int iommu_should_identity_map(struct device *dev, int startup);<br>
+<br>
=C2=A0 /* global iommu list, set NULL for ignored DMAR units */<br>
=C2=A0 static struct intel_iommu **g_iommus;<br>
<br>
@@ -2632,6 +2634,9 @@ static struct dmar_domain <br>
*find_or_alloc_domain(struct device *dev, int gaw)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (iommu_should_identity_map(dev, 0))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return si_domain;<b=
r>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Allocate and initialize new domain for=
 the device */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D alloc_domain(0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!domain)<br>
<br>
Best regards,<br>
Lu Baolu<br>
<br>
<br>
</blockquote></div>

--000000000000f11097058275d885--

--===============4687220231741463976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4687220231741463976==--
