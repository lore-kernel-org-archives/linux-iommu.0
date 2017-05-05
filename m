From: Geetha Akula <geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] iommu/arm-smmu-v3: Add workaround for Cavium
	ThunderX2 erratum #74
Date: Fri, 5 May 2017 17:43:37 +0530
Message-ID: <CANHdaibSBc3hVrisn7YQHEo1Z-nxMqr=Nzt4g6CO9XXjVtVBGQ@mail.gmail.com>
References: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
	<1493293584-20287-3-git-send-email-gakula@caviumnetworks.com>
	<20170427164237.GA7114@leverpostej> <20170427170030.GF1890@arm.com>
	<CANHdaibvzp22XEa3NnKAKUtrHcWGc9oUcnM8KubcYCzEfOaKJg@mail.gmail.com>
	<20170503094717.GC8233@arm.com>
	<75890ac7-19db-0b8b-cc74-248c36ef4dab@jonmasters.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9091601529263400079=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <75890ac7-19db-0b8b-cc74-248c36ef4dab-Zp4isUonpHBD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jon Masters <jcm-Zp4isUonpHBD60Wz+7aTrA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, catalin.marinas-5wv7dgnIgG8@public.gmane.org, Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============9091601529263400079==
Content-Type: multipart/alternative; boundary=001a11402298bd7de0054ec5d1c8

--001a11402298bd7de0054ec5d1c8
Content-Type: text/plain; charset=UTF-8

Hi Jon,

Charles Garcia-Tobin has confirmed that the new IORT spec includes Cavium
ThunderX model number.
I have resubmitted patches based on IORT model number.
https://www.spinics.net/lists/arm-kernel/msg579511.html


Thank you,
Geetha.


On Fri, May 5, 2017 at 5:06 AM, Jon Masters <jcm-Zp4isUonpHBD60Wz+7aTrA@public.gmane.org> wrote:

> On 05/03/2017 05:47 AM, Will Deacon wrote:
> > Hi Geetha,
> >
> > On Tue, May 02, 2017 at 12:01:15PM +0530, Geetha Akula wrote:
> >> SMMU_IIDR register is broken on T99, that the reason we are using MIDR.
> >
> > Urgh, that's unfortunate. In what way is it broken?
> >
> >> If using MIDR is not accepted, can we enable errata based on SMMU
> resource size?
> >> some thing like below.
> >
> > No, you need to get your model number added to IORT after all if the IIDR
> > can't uniqely identify the part.
> >
> > Sorry
>
> [I've pinged the IORT author directly with a copy of the above message]
>
> Can folks please take action urgently if the IORT spec needs updating to
> accommodate additional vendor IDs.
>
> Jon.
>
>

--001a11402298bd7de0054ec5d1c8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi Jon,<br><br>Charles Garcia-Tobin has confirme=
d that the new IORT spec includes Cavium ThunderX model number.<br>I have r=
esubmitted patches based on IORT model number. <br><a href=3D"https://www.s=
pinics.net/lists/arm-kernel/msg579511.html">https://www.spinics.net/lists/a=
rm-kernel/msg579511.html</a><br><br><br></div>Thank you,<br></div>Geetha.<b=
r><div><div><br></div></div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Fri, May 5, 2017 at 5:06 AM, Jon Masters <span dir=3D"l=
tr">&lt;<a href=3D"mailto:jcm-Zp4isUonpHBD60Wz+7aTrA@public.gmane.org" target=3D"_blank">jcm@jonmast=
ers.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">On 05/03/2017 05:47 AM, Will Deacon wrote:<br>
&gt; Hi Geetha,<br>
&gt;<br>
&gt; On Tue, May 02, 2017 at 12:01:15PM +0530, Geetha Akula wrote:<br>
&gt;&gt; SMMU_IIDR register is broken on T99, that the reason we are using =
MIDR.<br>
&gt;<br>
&gt; Urgh, that&#39;s unfortunate. In what way is it broken?<br>
&gt;<br>
&gt;&gt; If using MIDR is not accepted, can we enable errata based on SMMU =
resource size?<br>
&gt;&gt; some thing like below.<br>
&gt;<br>
&gt; No, you need to get your model number added to IORT after all if the I=
IDR<br>
&gt; can&#39;t uniqely identify the part.<br>
&gt;<br>
&gt; Sorry<br>
<br>
</span>[I&#39;ve pinged the IORT author directly with a copy of the above m=
essage]<br>
<br>
Can folks please take action urgently if the IORT spec needs updating to<br=
>
accommodate additional vendor IDs.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Jon.<br>
<br>
</font></span></blockquote></div><br></div>

--001a11402298bd7de0054ec5d1c8--

--===============9091601529263400079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9091601529263400079==--
