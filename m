Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3295EC10F03
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 17:38:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D0221738
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 17:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE7pN63S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D0221738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E4E74C8B;
	Tue, 23 Apr 2019 17:38:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8093CB2F
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 17:29:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
	[209.85.222.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4AD4DF4
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 17:29:07 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id p185so8972020qkb.8
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=rPDLFVfU39P+x01kk+za9ROO79ithKaj3/ZSfk2KJH0=;
	b=iE7pN63SBNY2f/M99XTtTqmrKfssdVtTHOS4RypJMulCcqKWj5O/se0vmhDMkI7EPc
	pXUEWWzRf1iNHsI5sLc+SWoVxTsQaEgnsGgBqKLkzRCKiO0SEUOvxieMFt8XYLCRnxmB
	WAGMpopTtN4GETcJLCOWcg9GSVuYM8GDFmXY3T7aYvdQYbToq62dslvEGs9N+qkx7I7Z
	G2ACy2accN2mNbsNWdjAeTY/UlGc1U8SbHU1cxk/xKiKgoOb7eCFv4uQ0eWPKT5sdrWp
	lOP3JnhWId+9ejPZ3PR4KODFoyv09jhcDVH3IqZcPJxg6ul16qBMiaMppVZE9Qi3Ljdy
	f+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=rPDLFVfU39P+x01kk+za9ROO79ithKaj3/ZSfk2KJH0=;
	b=bv9srEkbD3zuyc0e8W0BzKZ3o/F88P6oEtb3Ot5H/i2+SlTdOAIqmJ+dx49q+SClas
	w8nbAfL1xkPTR3MpyPQ/rPMNXNQRpbmYbRRchKBwZ4ngVguRza8BVP67hjyJBGk+guzJ
	i6JpuIslivQNWMHdkIAEWBMg4A3Hsz3hqNF8Oiy0WFNKbHZamvrAf92caiqV+CCZMDD+
	zRycIvwX6VvsAkM4cXGatAqYw/zv/o/unfzEv9XVu1mxTWhWHdgt22yOHmEKg4hyN7Fp
	Je7X3UqNsrb+UVLMFqEKgoPNQhAU6e0KAYX39Eo0EGfmdORnOe+f6L322nVFHIy41fbJ
	dLLA==
X-Gm-Message-State: APjAAAUqxAPfermga47qyqT6P9C41gpIXfyaD5374zqyXKvuN1B5/LOw
	gMN6+bTl1aBCAiQjxNrWyFY5PTgSvtY83weIyTg=
X-Google-Smtp-Source: APXvYqztlWAXIZEqzICfJ1jAIRAXz8bI4fQAwL7S1JiRkXYrQ4Sk0NhHFyEvsibVxQPb2ibeOzjFF8N1+yfha6HPCtg=
X-Received: by 2002:a37:6b01:: with SMTP id g1mr20462643qkc.280.1556040546055; 
	Tue, 23 Apr 2019 10:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
	<cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
	<20190423083135.GA11158@hirez.programming.kicks-ass.net>
	<20190423125519.GA7104@redhat.com>
	<20190423130132.GT4038@hirez.programming.kicks-ass.net>
	<20190423103053.07cf2149@lwn.net>
In-Reply-To: <20190423103053.07cf2149@lwn.net>
From: Wes Turner <wes.turner@gmail.com>
Date: Tue, 23 Apr 2019 13:28:53 -0400
Message-ID:
 <CACfEFw8By_-FR2Bx+-uAStBPxbHSJLSbQH9xY1DnL3axfhH2kQ@mail.gmail.com>
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST files
	to *.rst
To: Jonathan Corbet <corbet@lwn.net>
X-Mailman-Approved-At: Tue, 23 Apr 2019 17:38:50 +0000
Cc: Mike Snitzer <snitzer@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, Farhan Ali <alifm@linux.ibm.com>,
	Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
	Jaroslav Kysela <perex@perex.cz>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
	linux-sh@vger.kernel.org, James Morris <jmorris@namei.org>,
	Halil Pasic <pasic@linux.ibm.com>, tboot-devel@lists.sourceforge.net,
	Alan Stern <stern@rowland.harvard.edu>,
	openipmi-developer@lists.sourceforge.net,
	Guenter Roeck <linux@roeck-us.net>, Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Matt Mackall <mpm@selenic.com>, Thomas Gleixner <tglx@linutronix.de>,
	Sean Paul <sean@poorly.run>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-crypto@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org,
	linux-ia64@vger.kernel.org,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	David Airlie <airlied@linux.ie>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	dm-devel@redhat.com, Harry Wei <harryxiyou@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alasdair Kergon <agk@redhat.com>, linux-s390@vger.kernel.org,
	Alex Shi <alex.shi@linux.alibaba.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>,
	Eric Farman <farman@linux.ibm.com>,
	linux-watchdog@vger.kernel.org, Corey Minyard <minyard@acm.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	linaro-mm-sig@lists.linaro.org, linux-gpio@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
	Tony Luck <tony.luck@intel.com>, Cornelia Huck <cohuck@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Andrea Parri <andrea.parri@amarulasolutions.com>,
	linux-pci@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	platform-driver-x86@vger.kernel.org,
	"Paul E. McKenney" <paulmck@linux.ibm.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Peter Zijlstra <peterz@infradead.org>, Emese Revfy <re.emese@gmail.com>,
	Darren Hart <dvhart@infradead.org>, Jade Alglave <j.alglave@ucl.ac.uk>,
	"Serge E. Hallyn" <serge@hallyn.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Ning Sun <ning.sun@intel.com>, Borislav Petkov <bp@alien8.de>,
	Luc Maranget <luc.maranget@inria.fr>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Guan Xuetao <gxt@pku.edu.cn>, linux-parisc@vger.kernel.org,
	iommu@lists.linux-foundation.org, Stuart Hayes <stuart.w.hayes@gmail.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
	Rich Felker <dalias@libc.org>, kvm@vger.kernel.org,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Jerry Hoemann <jerry.hoemann@hpe.com>, David Howells <dhowells@redhat.com>,
	linux-mm <linux-mm@kvack.org>, Kirti Wankhede <kwankhede@nvidia.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Ingo Molnar <mingo@redhat.com>, devicetree@vger.kernel.org,
	Daniel Lustig <dlustig@nvidia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-block@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	Robin Murphy <robin.murphy@arm.com>, Andy Shevchenko <andy@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9030590852923772444=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190423172853.B9DvCOhrKjU3ZI9daAkBeap2CW3dv0QILg67QwORVDQ@z>

--===============9030590852923772444==
Content-Type: multipart/alternative; boundary="000000000000011047058735ecea"

--000000000000011047058735ecea
Content-Type: text/plain; charset="UTF-8"

- Accessible, usable docs are worth something in ROI
  - https://www.writethedocs.org/
  - https://read-the-docs.readthedocs.io/en/latest/
  -
https://github.com/rtfd/readthedocs-docker-images/issues/47#issuecomment-485712800
    - Dockerfile that extends from readthedocs/build:latest (which has the
GBs of latex necessary to run `make latexpdf` for all you PDF lovers out
there)

- https://github.com/yoloseem/awesome-sphinxdoc
  - There are various Sphinx extensions for optionally including generated
API docs for various languages
  - If you add the extensions you want installed to your requirements.txt
or environment.yml, ReadTheDocs will install those for every build. You can
also create (and maintain) a custom Docker image with all of the docs
building dependencies installed (e.g. requirements_dev.txt and/or
docs/requirements.txt)

- https://kernel.readthedocs.io/en/latest/kernel-documentation.html
  - This says "Copyright 2016"? That's set in conf.py

I keep a tools doc in ReST:
- https://westurner.github.io/tools/#sphinx
- https://westurner.github.io/tools/#docutils

I'll just CC those sections here
wrapped in a Markdown fenced code block

```rst

.. index:: Docutils
.. _docutils:

Docutils
~~~~~~~~~~~~~~~~~~~
| Homepage: http://docutils.sourceforge.net
| PyPI: https://pypi.python.org/pypi/docutils
| Docs: http://docutils.sourceforge.net/docs/
| Docs: http://docutils.sourceforge.net/rst.html
| Docs: http://docutils.sourceforge.net/docs/ref/doctree.html
| Docs: https://docutils.readthedocs.io/en/sphinx-docs/
| Docs:
https://docutils.readthedocs.io/en/sphinx-docs/ref/rst/restructuredtext.html
| Src: svn http://svn.code.sf.net/p/docutils/code/trunk

Docutils is a :ref:`Python` library which 'parses" :ref:`ReStructuredText`
lightweight markup language into a doctree (~DOM)
which can be serialized into
HTML, ePub, MOBI, LaTeX, man pages,
Open Document files,
XML, JSON, and a number of other formats.


.. index:: Sphinx
.. _sphinx:

Sphinx
~~~~~~~~~~~~~~~~~
| Wikipedia: `<
https://en.wikipedia.org/wiki/Sphinx_(documentation_generator)>`_
| Homepage: https://pypi.python.org/pypi/Sphinx
| Src: git https://github.com/sphinx-doc/sphinx
| Pypi: https://pypi.python.org/pypi/Sphinx
| Docs: http://sphinx-doc.org/contents.html
| Docs: http://sphinx-doc.org/markup/code.html
| Docs: http://www.sphinx-doc.org/en/stable/markup/inline.html#ref-role
| Docs: http://pygments.org/docs/lexers/
| Docs: http://thomas-cokelaer.info/tutorials/sphinx/rest_syntax.html
| Docs: https://github.com/yoloseem/awesome-sphinxdoc

Sphinx is a tool for working with
:ref:`ReStructuredText` documentation trees
and rendering them into HTML, PDF, LaTeX, ePub,
and a number of other formats.

[...]

```

FWIW, ReadTheDocs can host multiple versions of the docs according to the
repo
tags you specify in the web admin.
There may be a way to use the RTD JS UI for selecting versions
with the docs hosted on your own server?
Such as https://www.kernel.org/doc/html/latest/

- https://github.com/torvalds/linux/blob/master/Documentation/conf.py
- https://github.com/torvalds/linux/blob/master/Documentation/Makefile

-
https://github.com/torvalds/linux/blob/master/Documentation/doc-guide/index.rst
-
https://github.com/torvalds/linux/blob/master/Documentation/doc-guide/sphinx.rst
-
https://github.com/torvalds/linux/blob/master/Documentation/doc-guide/kernel-doc.rst

- https://www.kernel.org/doc/html/latest/
- https://www.kernel.org/doc/html/latest/doc-guide/
-
https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#sphinx-install
-
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#writing-kernel-doc-comments


On Tue, Apr 23, 2019 at 12:31 PM Jonathan Corbet <corbet@lwn.net> wrote:

> On Tue, 23 Apr 2019 15:01:32 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > But yes, I have 0 motivation to learn or abide by rst. It simply doesn't
> > give me anything in return. There is no upside, only worse text files :/
>
> So I believe it gives even you one thing in return: documentation that is
> more accessible for both readers and authors.  More readable docs should
> lead to more educated developers who understand the code better.  More
> writable docs will bring more people in to help to improve them.  The
> former effect has been reported in the GPU community, where they say that
> the quality of submissions has improved along with the docs.  The latter
> can be observed in the increased number of people working on the docs
> overall, something that Linus noted in the 5.1-rc1 announcement.
>
> Hopefully that's worth something :)
>
> Thanks,
>
> jon
>

--000000000000011047058735ecea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">- Accessible, usable docs are worth somet=
hing in ROI<br>=C2=A0 - <a href=3D"https://www.writethedocs.org/">https://w=
ww.writethedocs.org/</a><br>=C2=A0 - <a href=3D"https://read-the-docs.readt=
hedocs.io/en/latest/">https://read-the-docs.readthedocs.io/en/latest/</a><b=
r>=C2=A0 - <a href=3D"https://github.com/rtfd/readthedocs-docker-images/iss=
ues/47#issuecomment-485712800">https://github.com/rtfd/readthedocs-docker-i=
mages/issues/47#issuecomment-485712800</a><br>=C2=A0=C2=A0=C2=A0 - Dockerfi=
le that extends from readthedocs/build:latest (which has the GBs of latex n=
ecessary to run `make latexpdf` for all you PDF lovers out there)<br><br>- =
<a href=3D"https://github.com/yoloseem/awesome-sphinxdoc">https://github.co=
m/yoloseem/awesome-sphinxdoc</a><br>=C2=A0 - There are various Sphinx exten=
sions for optionally including generated API docs for various languages<br>=
=C2=A0 - If you add the extensions you want installed to your requirements.=
txt or environment.yml, ReadTheDocs will install those for every build. You=
 can also create (and maintain) a custom Docker image with all of the docs =
building dependencies installed (e.g. requirements_dev.txt and/or docs/requ=
irements.txt)<br><br>- <a href=3D"https://kernel.readthedocs.io/en/latest/k=
ernel-documentation.html">https://kernel.readthedocs.io/en/latest/kernel-do=
cumentation.html</a><br>=C2=A0 - This says &quot;Copyright 2016&quot;? That=
&#39;s set in conf.py<br><br>I keep a tools doc in ReST:<br>- <a href=3D"ht=
tps://westurner.github.io/tools/#sphinx">https://westurner.github.io/tools/=
#sphinx</a><br>- <a href=3D"https://westurner.github.io/tools/#docutils">ht=
tps://westurner.github.io/tools/#docutils</a><br><br>I&#39;ll just CC those=
 sections here<br>wrapped in a Markdown fenced code block<br><br>```rst<br>=
<br>.. index:: Docutils<br>.. _docutils:<br><br>Docutils<br>~~~~~~~~~~~~~~~=
~~~~<br>| Homepage: <a href=3D"http://docutils.sourceforge.net">http://docu=
tils.sourceforge.net</a><br>| PyPI: <a href=3D"https://pypi.python.org/pypi=
/docutils">https://pypi.python.org/pypi/docutils</a><br>| Docs: <a href=3D"=
http://docutils.sourceforge.net/docs/">http://docutils.sourceforge.net/docs=
/</a><br>| Docs: <a href=3D"http://docutils.sourceforge.net/rst.html">http:=
//docutils.sourceforge.net/rst.html</a><br>| Docs: <a href=3D"http://docuti=
ls.sourceforge.net/docs/ref/doctree.html">http://docutils.sourceforge.net/d=
ocs/ref/doctree.html</a><br>| Docs: <a href=3D"https://docutils.readthedocs=
.io/en/sphinx-docs/">https://docutils.readthedocs.io/en/sphinx-docs/</a><br=
>| Docs: <a href=3D"https://docutils.readthedocs.io/en/sphinx-docs/ref/rst/=
restructuredtext.html">https://docutils.readthedocs.io/en/sphinx-docs/ref/r=
st/restructuredtext.html</a><br>| Src: svn <a href=3D"http://svn.code.sf.ne=
t/p/docutils/code/trunk">http://svn.code.sf.net/p/docutils/code/trunk</a><b=
r><br>Docutils is a :ref:`Python` library which &#39;parses&quot; :ref:`ReS=
tructuredText`<br>lightweight markup language into a doctree (~DOM)<br>whic=
h can be serialized into<br>HTML, ePub, MOBI, LaTeX, man pages,<br>Open Doc=
ument files,<br>XML, JSON, and a number of other formats.<br><br><br>.. ind=
ex:: Sphinx<br>.. _sphinx:<br><br>Sphinx<br>~~~~~~~~~~~~~~~~~<br>| Wikipedi=
a: `&lt;<a href=3D"https://en.wikipedia.org/wiki/Sphinx_(documentation_gene=
rator)">https://en.wikipedia.org/wiki/Sphinx_(documentation_generator)</a>&=
gt;`_<br>| Homepage: <a href=3D"https://pypi.python.org/pypi/Sphinx">https:=
//pypi.python.org/pypi/Sphinx</a><br>| Src: git <a href=3D"https://github.c=
om/sphinx-doc/sphinx">https://github.com/sphinx-doc/sphinx</a><br>| Pypi: <=
a href=3D"https://pypi.python.org/pypi/Sphinx">https://pypi.python.org/pypi=
/Sphinx</a><br>| Docs: <a href=3D"http://sphinx-doc.org/contents.html">http=
://sphinx-doc.org/contents.html</a><br>| Docs: <a href=3D"http://sphinx-doc=
.org/markup/code.html">http://sphinx-doc.org/markup/code.html</a><br>| Docs=
: <a href=3D"http://www.sphinx-doc.org/en/stable/markup/inline.html#ref-rol=
e">http://www.sphinx-doc.org/en/stable/markup/inline.html#ref-role</a><br>|=
 Docs: <a href=3D"http://pygments.org/docs/lexers/">http://pygments.org/doc=
s/lexers/</a><br>| Docs: <a href=3D"http://thomas-cokelaer.info/tutorials/s=
phinx/rest_syntax.html">http://thomas-cokelaer.info/tutorials/sphinx/rest_s=
yntax.html</a><br>| Docs: <a href=3D"https://github.com/yoloseem/awesome-sp=
hinxdoc">https://github.com/yoloseem/awesome-sphinxdoc</a><br><br>Sphinx is=
 a tool for working with<br>:ref:`ReStructuredText` documentation trees<br>=
and rendering them into HTML, PDF, LaTeX, ePub,<br>and a number of other fo=
rmats.<br><br>[...]<br><br>```<br><br>FWIW, ReadTheDocs can host multiple v=
ersions of the docs according to the repo<br>tags you specify in the web ad=
min.<br>There may be a way to use the RTD JS UI for selecting versions<br>w=
ith the docs hosted on your own server?<br>Such as <a href=3D"https://www.k=
ernel.org/doc/html/latest/">https://www.kernel.org/doc/html/latest/</a><br>=
<br>- <a href=3D"https://github.com/torvalds/linux/blob/master/Documentatio=
n/conf.py">https://github.com/torvalds/linux/blob/master/Documentation/conf=
.py</a><br>- <a href=3D"https://github.com/torvalds/linux/blob/master/Docum=
entation/Makefile">https://github.com/torvalds/linux/blob/master/Documentat=
ion/Makefile</a><br><br>- <a href=3D"https://github.com/torvalds/linux/blob=
/master/Documentation/doc-guide/index.rst">https://github.com/torvalds/linu=
x/blob/master/Documentation/doc-guide/index.rst</a><br>- <a href=3D"https:/=
/github.com/torvalds/linux/blob/master/Documentation/doc-guide/sphinx.rst">=
https://github.com/torvalds/linux/blob/master/Documentation/doc-guide/sphin=
x.rst</a><br>- <a href=3D"https://github.com/torvalds/linux/blob/master/Doc=
umentation/doc-guide/kernel-doc.rst">https://github.com/torvalds/linux/blob=
/master/Documentation/doc-guide/kernel-doc.rst</a><br><br>- <a href=3D"http=
s://www.kernel.org/doc/html/latest/">https://www.kernel.org/doc/html/latest=
/</a><br>- <a href=3D"https://www.kernel.org/doc/html/latest/doc-guide/">ht=
tps://www.kernel.org/doc/html/latest/doc-guide/</a><br>- <a href=3D"https:/=
/www.kernel.org/doc/html/latest/doc-guide/sphinx.html#sphinx-install">https=
://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#sphinx-install</a><=
br>- <a href=3D"https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc=
.html#writing-kernel-doc-comments">https://www.kernel.org/doc/html/latest/d=
oc-guide/kernel-doc.html#writing-kernel-doc-comments</a><br><br></div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tu=
e, Apr 23, 2019 at 12:31 PM Jonathan Corbet &lt;<a href=3D"mailto:corbet@lw=
n.net">corbet@lwn.net</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">On Tue, 23 Apr 2019 15:01:32 +0200<br>
Peter Zijlstra &lt;<a href=3D"mailto:peterz@infradead.org" target=3D"_blank=
">peterz@infradead.org</a>&gt; wrote:<br>
<br>
&gt; But yes, I have 0 motivation to learn or abide by rst. It simply doesn=
&#39;t<br>
&gt; give me anything in return. There is no upside, only worse text files =
:/<br>
<br>
So I believe it gives even you one thing in return: documentation that is<b=
r>
more accessible for both readers and authors.=C2=A0 More readable docs shou=
ld<br>
lead to more educated developers who understand the code better.=C2=A0 More=
<br>
writable docs will bring more people in to help to improve them.=C2=A0 The<=
br>
former effect has been reported in the GPU community, where they say that<b=
r>
the quality of submissions has improved along with the docs.=C2=A0 The latt=
er<br>
can be observed in the increased number of people working on the docs<br>
overall, something that Linus noted in the 5.1-rc1 announcement.<br>
<br>
Hopefully that&#39;s worth something :)<br>
<br>
Thanks,<br>
<br>
jon<br>
</blockquote></div>

--000000000000011047058735ecea--

--===============9030590852923772444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============9030590852923772444==--
