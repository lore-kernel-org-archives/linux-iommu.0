From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [RFC PATCH v5 02/11] ARM SMMU: Add capability IOMMU_CAP_DMA_EXEC
Date: Tue, 29 Apr 2014 11:49:48 +0200
Message-ID: <CAG8rG2xGPLjuVBn6fwHdLAnawsyKBudgZMysHL6XOmMmtCGD8A@mail.gmail.com>
References: <1398700371-20096-1-git-send-email-a.motakis@virtualopensystems.com>
	<1398700371-20096-3-git-send-email-a.motakis@virtualopensystems.com>
	<20140428193709.GE22135@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6343610371212242751=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140428193709.GE22135-5wv7dgnIgG8@public.gmane.org>
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
Cc: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "moderated list:ARM SMMU DRIVER" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============6343610371212242751==
Content-Type: multipart/alternative; boundary=047d7b15a16d7fa0e104f82b5bde

--047d7b15a16d7fa0e104f82b5bde
Content-Type: text/plain; charset=ISO-8859-1

I agree, that would be simpler for the user. As it is now we have to worry
about whether the EXEC flac is available just to use the PL330, with NOEXEC
the device would always be usable by default.


On Mon, Apr 28, 2014 at 9:37 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:

> On Mon, Apr 28, 2014 at 04:52:42PM +0100, Antonios Motakis wrote:
> > The ARM SMMU can take an IOMMU_EXEC protection flag in addition to
> > IOMMU_READ and IOMMU_WRITE. Expose this as an IOMMU capability.
>
> The other way of handling this would be to negate the capability and
> advertise a NOEXEC cap instead. That would need the IOMMU_EXEC flag to
> become IOMMU_NOEXEC and the ARM SMMU driver updating accordingly, but it
> might make more sense if people don't object to mixing positive and
> negative
> logic in the IOMMU_* flags.
>
> Any thoughts?
>
> Will
>



-- 
Antonios Motakis
Virtual Open Systems

--047d7b15a16d7fa0e104f82b5bde
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I agree, that would be simpler for the user. As it is now =
we have to worry about whether the EXEC flac is available just to use the P=
L330, with NOEXEC the device would always be usable by default.<br></div><d=
iv class=3D"gmail_extra">

<br><br><div class=3D"gmail_quote">On Mon, Apr 28, 2014 at 9:37 PM, Will De=
acon <span dir=3D"ltr">&lt;<a href=3D"mailto:will.deacon-5wv7dgnIgG8@public.gmane.org" target=3D=
"_blank">will.deacon-5wv7dgnIgG8@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">

<div class=3D"">On Mon, Apr 28, 2014 at 04:52:42PM +0100, Antonios Motakis =
wrote:<br>
&gt; The ARM SMMU can take an IOMMU_EXEC protection flag in addition to<br>
&gt; IOMMU_READ and IOMMU_WRITE. Expose this as an IOMMU capability.<br>
<br>
</div>The other way of handling this would be to negate the capability and<=
br>
advertise a NOEXEC cap instead. That would need the IOMMU_EXEC flag to<br>
become IOMMU_NOEXEC and the ARM SMMU driver updating accordingly, but it<br=
>
might make more sense if people don&#39;t object to mixing positive and neg=
ative<br>
logic in the IOMMU_* flags.<br>
<br>
Any thoughts?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Will<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Antonios =
Motakis<br>Virtual Open Systems
</div>

--047d7b15a16d7fa0e104f82b5bde--

--===============6343610371212242751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6343610371212242751==--
