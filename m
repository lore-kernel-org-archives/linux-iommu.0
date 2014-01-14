From: Yifan Zhang <yifan.zhangm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: change pud/pmd entry fill sequence
Date: Tue, 14 Jan 2014 17:02:49 +0800
Message-ID: <CAGZxSSSjhqg4vnw__qoW0zLibEG_1FChrHWFFUorkV65Sq0ogg@mail.gmail.com>
References: <1388750486-5060-1-git-send-email-yifan.zhangm@gmail.com>
	<20140106142833.GC10449@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1495729808621217852=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140106142833.GC10449-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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
Cc: Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Yifan Zhang <zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============1495729808621217852==
Content-Type: multipart/alternative; boundary=f46d043d66e1e8acd604efea74da

--f46d043d66e1e8acd604efea74da
Content-Type: text/plain; charset=ISO-8859-1

 Hi Will,

It seems this patch is still not merged yet, any concerns about it ?

BR,
Yifan


On Mon, Jan 6, 2014 at 10:28 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:

> On Fri, Jan 03, 2014 at 12:01:26PM +0000, Yifan Zhang wrote:
> > From: Yifan Zhang <zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> >
> > Pgd/pud entry should be filled only once when their next level pud/pmd
> > created, the value should be pud/pmd start address, while in current
> > code, pgd/pud entry is filled every time when pud/pmd walk occurs,
> > the value is pud/pmd start address + iova pud/pmd index , this is
> > incorrect; Besides, when pud/pmd are created, we need to add pud/pmd
> > index, then pass to next level, while in currect code, if a new pud/pmd
> > created, their iova pud/pmd index is not taken into account, only
> > existing pud/pmd do. This patch change pud/pmd entry fill sequence,
> > fixes the 2 bugs.
> >
> > Signed-off-by: Yifan Zhang <zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>
> Thanks Yifan, this looks good to me. It's strange that I got the pte
> handling correct, but screwed up the equivalent pmd and pud code!
>
> Will
>

--f46d043d66e1e8acd604efea74da
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>=A0Hi Will,</div><div><br></div><div>It seems this pa=
tch is still not merged yet, any concerns about it ?</div><div><br></div><d=
iv>BR,</div><div>Yifan</div></div><div class=3D"gmail_extra"><br><br><div c=
lass=3D"gmail_quote">
On Mon, Jan 6, 2014 at 10:28 PM, Will Deacon <span dir=3D"ltr">&lt;<a href=
=3D"mailto:will.deacon-5wv7dgnIgG8@public.gmane.org" target=3D"_blank">will.deacon-5wv7dgnIgG8@public.gmane.org</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On Fri, Jan 03, 2014 at 12:01:26PM +0000, Yifan Zhang wro=
te:<br>
&gt; From: Yifan Zhang &lt;<a href=3D"mailto:zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org">zhangyf@m=
arvell.com</a>&gt;<br>
&gt;<br>
&gt; Pgd/pud entry should be filled only once when their next level pud/pmd=
<br>
&gt; created, the value should be pud/pmd start address, while in current<b=
r>
&gt; code, pgd/pud entry is filled every time when pud/pmd walk occurs,<br>
&gt; the value is pud/pmd start address + iova pud/pmd index , this is<br>
&gt; incorrect; Besides, when pud/pmd are created, we need to add pud/pmd<b=
r>
&gt; index, then pass to next level, while in currect code, if a new pud/pm=
d<br>
&gt; created, their iova pud/pmd index is not taken into account, only<br>
&gt; existing pud/pmd do. This patch change pud/pmd entry fill sequence,<br=
>
&gt; fixes the 2 bugs.<br>
&gt;<br>
&gt; Signed-off-by: Yifan Zhang &lt;<a href=3D"mailto:zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org">=
zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
<br>
</div>Thanks Yifan, this looks good to me. It&#39;s strange that I got the =
pte<br>
handling correct, but screwed up the equivalent pmd and pud code!<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Will<br>
</font></span></blockquote></div><br></div>

--f46d043d66e1e8acd604efea74da--

--===============1495729808621217852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1495729808621217852==--
