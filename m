From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH 00/21] DT cpu node iterator
Date: Fri, 7 Sep 2018 14:54:20 +0200
Message-ID: <CAHTX3d+BFKM-jFo8Ww_dXwAzsDVoWqE==erfwVTeijHfh8kkOw@mail.gmail.com>
References: <20180905193738.19325-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0971646821141865186=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180905193738.19325-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vitaly Bordug <vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Palmer Dabbelt <palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Stefan Kristiansson <stefan.kristiansson-MbMCFXIvDHJFcC0YU169RA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, linux-riscv-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgAlbert Ou <a>
List-Id: iommu@lists.linux-foundation.org

--===============0971646821141865186==
Content-Type: multipart/alternative; boundary="0000000000009fa1d105754781ee"

--0000000000009fa1d105754781ee
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

2018-09-05 21:37 GMT+02:00 Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:

> This series adds an iterator for cpu nodes and converts users over to use
> it or of_get_cpu_node in some cases. This allows us to remove the
> dependency on device_type property for cpu nodes though removing that
> from DTS files will have to wait for some time. In some cases, this makes
> the DT search more strict by only looking in /cpus child nodes rather
> than any node with the device_type == cpu. The iterator also honors the
> status property which is often forgotten.
>
> I've only tested on ARM under QEMU and compiled powerpc.
>


Do you have this somewhere in your tree not to apply 21 patches by hand?

Thanks,
Michal

--0000000000009fa1d105754781ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Rob,<br><div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">2018-09-05 21:37 GMT+02:00 Rob Herring <span dir=3D"ltr">&=
lt;<a href=3D"mailto:robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" target=3D"_blank">robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org</a>=
&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">This series adds an iterator=
 for cpu nodes and converts users over to use<br>
it or of_get_cpu_node in some cases. This allows us to remove the<br>
dependency on device_type property for cpu nodes though removing that<br>
from DTS files will have to wait for some time. In some cases, this makes<b=
r>
the DT search more strict by only looking in /cpus child nodes rather<br>
than any node with the device_type =3D=3D cpu. The iterator also honors the=
<br>
status property which is often forgotten.<br>
<br>
I&#39;ve only tested on ARM under QEMU and compiled powerpc.<br></blockquot=
e><div><br></div><div><br></div><div>Do you have this somewhere in your tre=
e not to apply 21 patches by hand?</div><div><br></div><div>Thanks,</div><d=
iv>Michal<br></div><div>=C2=A0</div></div><br></div></div></div>

--0000000000009fa1d105754781ee--

--===============0971646821141865186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0971646821141865186==--
