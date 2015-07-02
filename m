From: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: Master-aware devices and sideband ID data
Date: Thu, 2 Jul 2015 20:26:55 +0000
Message-ID: <91AAB3D7-8650-42FE-B0C1-48A5A1C73194@caviumnetworks.com>
References: <20150324155007.GC23005@leverpostej>
	<26BE36EF-2C5B-4DA6-8950-8FEBB031ED1B@caviumnetworks.com>
	<20150527173953.GC23176@leverpostej>
	<E342D737-5DD5-48C7-BB01-B83C29CB6E31@caviumnetworks.com>
	<20150601102208.GD22406@leverpostej>
	<158EFC9F-FCAF-44D3-AD40-804EDFE0CE25@caviumnetworks.com>
	<20150605090534.GC1198@arm.com> <20150609101515.GA28474@leverpostej>
	<20150610081120.GA22973@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3803630334647653476=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150610081120.GA22973-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============3803630334647653476==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_91AAB3D7865042FEB0C148A5A1C73194caviumnetworkscom_"

--_000_91AAB3D7865042FEB0C148A5A1C73194caviumnetworkscom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

any update on this?
On Jun 10, 2015, at 1:11 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org<mailto:will.d=
eacon-5wv7dgnIgG8@public.gmane.org>> wrote:

On Tue, Jun 09, 2015 at 11:17:54AM +0100, Mark Rutland wrote:
On Fri, Jun 05, 2015 at 10:05:34AM +0100, Will Deacon wrote:
On Thu, Jun 04, 2015 at 11:19:30PM +0100, Chalamarla, Tirumalesh wrote:
On Jun 1, 2015, at 3:22 AM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org<mailto:mark.=
rutland-5wv7dgnIgG8@public.gmane.org>> wrote:
It's possible to specify that the paths exist. I expect that software
would select which to use at runtime.

My worry is how to define any priorities/preferences between masters.
in general the proposal looks reasonable.

I agree that the proposal looks reasonable (in terms of the ability to
describe the sort of topologies that we will face) but I still don't
understand what I need to do in e.g. my IOMMU driver to support this
binding whilst continuing to support the existing iommus binding, which
is relied upon to configure dma-mapping.

Mark: how do you see this co-existing/merging with the current bindings?

As I mentioned in my initial mail, it's not clear to me how this can be
reconciled with the current bindings. Everything I've been able to come
up with so far at best ends up describing the same thing repeatedly.

I'll see what I can come up with. Any sugestions are welcome!

Well, I'd start with the current iommu binding and see if you can figure
out which properties need adding to it in order to describe the sort of
topologies you can describe with your original proposal.

I don't think it's practical to throw away what we have and move over to
something totally different all in one go, but there clearly *is* benefit
in your proposal over the existing scheme.

I can see that's probably not practical. :(

Do we know what we're going to do w.r.t. IORT? That's going to require
the kernel to be able to handle a similar description to this proposal.

IORT is part of ACPI, so it doesn't care about the existing DT binding
and doesn't need to co-exist at runtime.

Will


--_000_91AAB3D7865042FEB0C148A5A1C73194caviumnetworkscom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <CDD63933095B3D4A8BA56E499C4B37B1-Tk6F3M/euE6cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space;" class=3D"">
any update on this?&nbsp;<br class=3D"">
<div style=3D"">
<blockquote type=3D"cite" class=3D"">
<div class=3D"">On Jun 10, 2015, at 1:11 AM, Will Deacon &lt;<a href=3D"mai=
lto:will.deacon-5wv7dgnIgG8@public.gmane.org" class=3D"">will.deacon-5wv7dgnIgG8@public.gmane.org</a>&gt; wrote:</div=
>
<br class=3D"Apple-interchange-newline">
<div class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; fon=
t-style: normal; font-variant: normal; font-weight: normal; letter-spacing:=
 normal; line-height: normal; orphans: auto; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; widows: auto; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; float: none; display: inline !impor=
tant;" class=3D"">On
 Tue, Jun 09, 2015 at 11:17:54AM &#43;0100, Mark Rutland wrote:</span><br s=
tyle=3D"font-family: Helvetica; font-size: 12px; font-style: normal; font-v=
ariant: normal; font-weight: normal; letter-spacing: normal; line-height: n=
ormal; orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-st=
roke-width: 0px;" class=3D"">
<blockquote type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant: normal; font-weight: normal; letter-spac=
ing: normal; line-height: normal; orphans: auto; text-align: start; text-in=
dent: 0px; text-transform: none; white-space: normal; widows: auto; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">
On Fri, Jun 05, 2015 at 10:05:34AM &#43;0100, Will Deacon wrote:<br class=
=3D"">
<blockquote type=3D"cite" class=3D"">On Thu, Jun 04, 2015 at 11:19:30PM &#4=
3;0100, Chalamarla, Tirumalesh wrote:<br class=3D"">
<blockquote type=3D"cite" class=3D"">
<blockquote type=3D"cite" class=3D"">On Jun 1, 2015, at 3:22 AM, Mark Rutla=
nd &lt;<a href=3D"mailto:mark.rutland-5wv7dgnIgG8@public.gmane.org" class=3D"">mark.rutland@arm.=
com</a>&gt; wrote:<br class=3D"">
It's possible to specify that the paths exist. I expect that software<br cl=
ass=3D"">
would select which to use at runtime.<br class=3D"">
<br class=3D"">
</blockquote>
My worry is how to define any priorities/preferences between masters.<span =
class=3D"Apple-converted-space">&nbsp;</span><br class=3D"">
in general the proposal looks reasonable.<br class=3D"">
</blockquote>
<br class=3D"">
I agree that the proposal looks reasonable (in terms of the ability to<br c=
lass=3D"">
describe the sort of topologies that we will face) but I still don't<br cla=
ss=3D"">
understand what I need to do in e.g. my IOMMU driver to support this<br cla=
ss=3D"">
binding whilst continuing to support the existing iommus binding, which<br =
class=3D"">
is relied upon to configure dma-mapping.<br class=3D"">
<br class=3D"">
Mark: how do you see this co-existing/merging with the current bindings?<br=
 class=3D"">
</blockquote>
<br class=3D"">
As I mentioned in my initial mail, it's not clear to me how this can be<br =
class=3D"">
reconciled with the current bindings. Everything I've been able to come<br =
class=3D"">
up with so far at best ends up describing the same thing repeatedly.<br cla=
ss=3D"">
<br class=3D"">
I'll see what I can come up with. Any sugestions are welcome!<br class=3D""=
>
</blockquote>
<br style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; f=
ont-variant: normal; font-weight: normal; letter-spacing: normal; line-heig=
ht: normal; orphans: auto; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-te=
xt-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">Well,
 I'd start with the current iommu binding and see if you can figure</span><=
br style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; fo=
nt-variant: normal; font-weight: normal; letter-spacing: normal; line-heigh=
t: normal; orphans: auto; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">out
 which properties need adding to it in order to describe the sort of</span>=
<br style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; f=
ont-variant: normal; font-weight: normal; letter-spacing: normal; line-heig=
ht: normal; orphans: auto; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-te=
xt-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">topologies
 you can describe with your original proposal.</span><br style=3D"font-fami=
ly: Helvetica; font-size: 12px; font-style: normal; font-variant: normal; f=
ont-weight: normal; letter-spacing: normal; line-height: normal; orphans: a=
uto; text-align: start; text-indent: 0px; text-transform: none; white-space=
: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;"=
 class=3D"">
<br style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; f=
ont-variant: normal; font-weight: normal; letter-spacing: normal; line-heig=
ht: normal; orphans: auto; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-te=
xt-stroke-width: 0px;" class=3D"">
<blockquote type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant: normal; font-weight: normal; letter-spac=
ing: normal; line-height: normal; orphans: auto; text-align: start; text-in=
dent: 0px; text-transform: none; white-space: normal; widows: auto; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">
<blockquote type=3D"cite" class=3D"">I don't think it's practical to throw =
away what we have and move over to<br class=3D"">
something totally different all in one go, but there clearly *is* benefit<b=
r class=3D"">
in your proposal over the existing scheme.<br class=3D"">
</blockquote>
<br class=3D"">
I can see that's probably not practical. :(<br class=3D"">
<br class=3D"">
Do we know what we're going to do w.r.t. IORT? That's going to require<br c=
lass=3D"">
the kernel to be able to handle a similar description to this proposal.<br =
class=3D"">
</blockquote>
<br style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; f=
ont-variant: normal; font-weight: normal; letter-spacing: normal; line-heig=
ht: normal; orphans: auto; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-te=
xt-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">IORT
 is part of ACPI, so it doesn't care about the existing DT binding</span><b=
r style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; fon=
t-variant: normal; font-weight: normal; letter-spacing: normal; line-height=
: normal; orphans: auto; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text=
-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">and
 doesn't need to co-exist at runtime.</span><br style=3D"font-family: Helve=
tica; font-size: 12px; font-style: normal; font-variant: normal; font-weigh=
t: normal; letter-spacing: normal; line-height: normal; orphans: auto; text=
-align: start; text-indent: 0px; text-transform: none; white-space: normal;=
 widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D=
"">
<br style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; f=
ont-variant: normal; font-weight: normal; letter-spacing: normal; line-heig=
ht: normal; orphans: auto; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-te=
xt-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">Will</span></div>
</blockquote>
</div>
<br class=3D"">
</body>
</html>

--_000_91AAB3D7865042FEB0C148A5A1C73194caviumnetworkscom_--

--===============3803630334647653476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3803630334647653476==--
