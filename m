From: Konrad Rzeszutek Wilk <konrad-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] PCI: Introduce new device binding path using
	pci_dev.driver_override
Date: Fri, 16 May 2014 10:48:00 -0400
Message-ID: <CACJDEmp+whOkOZ5pVn4qqNBqXJc5Nb=1m-DmxPzFUZNxEyG6gQ@mail.gmail.com>
References: <20140509164326.12141.44591.stgit@bling.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3112034125818220814=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140509164326.12141.44591.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, KVM <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, libvir-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============3112034125818220814==
Content-Type: multipart/alternative; boundary=047d7bd76b900b25ec04f985803b

--047d7bd76b900b25ec04f985803b
Content-Type: text/plain; charset=UTF-8

On Fri, May 9, 2014 at 12:50 PM, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> wrote:

> The driver_override field allows us to specify the driver for a device
> ...
>
...

> Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

--047d7bd76b900b25ec04f985803b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Fri, May 9, 2014 at 12:50 PM, Alex Williamson <span dir=3D"ltr">=
&lt;<a href=3D"mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">alex.wi=
lliamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">The driver_override field allows us to speci=
fy the driver for a device<br>...<br></blockquote><div>...=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">

Signed-off-by: Alex Williamson &lt;<a href=3D"mailto:alex.williamson@redhat=
.com">alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
Cc: Greg Kroah-Hartman &lt;<a href=3D"mailto:gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org">gr=
egkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org</a>&gt;<br></blockquote><div><br></div><div>Review=
ed-by: Konrad Rzeszutek Wilk &lt;<a href=3D"mailto:konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org">=
konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org</a>&gt;</div>
<div>=C2=A0</div></div></div></div>

--047d7bd76b900b25ec04f985803b--

--===============3112034125818220814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3112034125818220814==--
