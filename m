From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/9] dma: pl330: rip out broken, redundant ID probing
Date: Tue, 11 Jun 2013 10:07:37 +0530
Message-ID: <CAJe_Zhcmn7UuZbP+OzSp+nHqm9h9f93cmBXQX5B7m54kfvuerQ@mail.gmail.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
	<1370889285-22799-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2318958693378767084=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1370889285-22799-2-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============2318958693378767084==
Content-Type: multipart/alternative; boundary=047d7b4724f4e1d02804ded97417

--047d7b4724f4e1d02804ded97417
Content-Type: text/plain; charset=ISO-8859-1

On 11 June 2013 00:04, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:

> The PL330 driver probes the peripheral and primecell IDs of the device to
> make sure that it is indeed an AMBA PL330. However, it does this by
> making byte accesses to a device mapping of the word-aligned ID
> registers, which is either UNPREDICTABLE or generates an alignment fault
> (depending on the presence of the virtualisation extensions).
>
> Rather than fix this code, we can actually rip most of it out and let
> the AMBA bus driver correctly do the probing for us.
>
> Acked-by: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

--047d7b4724f4e1d02804ded97417
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On 11 June 2013 00:04, Will Deacon <span dir=3D"ltr">&lt;<=
a href=3D"mailto:will.deacon-5wv7dgnIgG8@public.gmane.org" target=3D"_blank">will.deacon-5wv7dgnIgG8@public.gmane.org=
</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:so=
lid;padding-left:1ex">
The PL330 driver probes the peripheral and primecell IDs of the device to<b=
r>
make sure that it is indeed an AMBA PL330. However, it does this by<br>
making byte accesses to a device mapping of the word-aligned ID<br>
registers, which is either UNPREDICTABLE or generates an alignment fault<br=
>
(depending on the presence of the virtualisation extensions).<br>
<br>
Rather than fix this code, we can actually rip most of it out and let<br>
the AMBA bus driver correctly do the probing for us.<br>
<br></blockquote><div>Acked-by: Jassi Brar &lt;<a href=3D"mailto:jaswinder.=
singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;</div></div></div></div=
>

--047d7b4724f4e1d02804ded97417--

--===============2318958693378767084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2318958693378767084==--
