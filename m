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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B10C10F03
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 17:38:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113FE21738
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 17:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdjMzqBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113FE21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A58A9C84;
	Tue, 23 Apr 2019 17:38:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CDB10CCE
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 17:14:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
	[209.85.222.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 29E2DF4
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 17:14:09 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id c1so9072265qkk.4
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=UhIFIHAGtzWam4U3kZx8nXrhSBuSr2mmpC3hsxaKykc=;
	b=FdjMzqBmZP/4oxmgdJrzvpOJgx1EKD8rrbw5664E8KXcaDLHBClen6syH3ruQ4Fwka
	VyOvscSRsS1CuJufvzpAV3xuEBMozd8BYXjsZU+e4uRTYfz6MF7lGwDdL6vlwkR3ejdT
	DfVf6cNFLeed+XaNCFqefSVo3uXxToFKbF0+dRvIDdkYG9z1u2+7gzZWTIc9jWRz4THB
	3eSvPB4xVefR0gwyU/dgdS94OmY7JeyfCxNnt/UnSv3UHDgc3Trm0/c10buNMd6TdG4s
	jNfG5rms8PA2BYSW5uJ9foHd5yHbQgPmJCQenNCxAq7bQwTT907rRPCOroFvO6qqfjlP
	4VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=UhIFIHAGtzWam4U3kZx8nXrhSBuSr2mmpC3hsxaKykc=;
	b=mwgB1bWRYFpPChm6kjMS/pyQkhetXDsLVZRavBGlQ1Kw8WuEMI+sYJi9Ba5oYcbNyS
	9cmXT/MpNgFdR3nVtZi1qw5PTqM242f5L8AJOrNV8TM6tqH1zDAl2JujcL2ZsTLVzRii
	sVtDPfGGLx52CGXkprvZt+rf7vfTaf83pyvnLC59BhsySmqLMVfw/jYhpS/5Q6tYEfJz
	4R3anJNl9beMyeIzhcPIvd7xgocdKNs/hxVVk2kDNB620B4KOWnswbU9/GlCXBH/AuaH
	uh6ktXBzgy7/qPnJXkmjH85f1naPL8n4tHXvK/H5hyk9z0J8OjpJG9OGF5zRC7y0p4Vm
	Jxqw==
X-Gm-Message-State: APjAAAUyWP5V3Ei8+oZ2eM5R5kD3HX/B9JvqYd2ndPgw93Lp9GL3eYxg
	YG1YpbwZ6CwkTV1kqyDhTRMcNnPePl74buQ+6RI=
X-Google-Smtp-Source: APXvYqy6gPBjQdPn9lRryBYtVNXGGO8ngYfIpvS2v/833izrPkLscuZ9vo3nNT6c4KfcP1LkMiHri10SVfmaBQLuHhY=
X-Received: by 2002:a05:620a:16c5:: with SMTP id
	a5mr20301658qkn.212.1556039647994; 
	Tue, 23 Apr 2019 10:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
	<cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
	<20190423083135.GA11158@hirez.programming.kicks-ass.net>
	<20190423125519.GA7104@redhat.com>
	<20190423130132.GT4038@hirez.programming.kicks-ass.net>
	<20190423103053.07cf2149@lwn.net>
In-Reply-To: <20190423103053.07cf2149@lwn.net>
From: Wes Turner <wes.turner@gmail.com>
Date: Tue, 23 Apr 2019 13:13:54 -0400
Message-ID:
 <CACfEFw-viqBH7tDJ8t_um5erPFnRmzuztux86+3XR0+e=YcYYA@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============4179755425576992558=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190423171354.gEytVxRY_fFmDernoWwlJahOanRdWPWGwOqhrNdhoIg@z>

--===============4179755425576992558==
Content-Type: multipart/alternative; boundary="00000000000079b931058735b68c"

--00000000000079b931058735b68c
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

I'll just CC those sections here:

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

Sphinx extends :ref:`Docutils` with a number of useful markup behaviors
which are not supported by other ReStructuredText parsers.

Most other ReStructuredText parsers do not support Sphinx directives;
so, for example,

* GitHub and BitBucket do not support Sphinx but do support ReStructuredText
  so ``README.rst`` containing Sphinx tags renders in plaintext or raises
errors.

  For example, the index page of this
  :ref:`Sphinx` documentation set is generated from
  a file named ``index.rst`` that referenced by ``docs/conf.py``,
  which is utilized by ``sphinx-build`` in the ``Makefile``.

  * Input:

    .. code:: bash

      _indexrst="$WORKON_HOME/src/westurner/tools/index.rst"
      e $_indexrst

      # with westurner/dotfiles.venv
      mkvirtualenv westurner
      we westurner tools; mkdir -p $_SRC
      git clone ssh://git@github.com/westurner/tools
      cdw; e index.rst    # ew index.rst

    https://github.com/westurner/tools/blob/master/index.rst

    https://raw.githubusercontent.com/westurner/tools/master/index.rst



  * Output:

    .. code:: bash

      cd $_WRD                        # cdwrd; cdw
      git status; make <tab>          # gitw status; makew <tab>
      make html singlehtml            # make docs
      web ./_build/html/index.html    # make open

      make gh-pages       # ghp-import -n -p ./_build/html/ -b gh-pages
      make push           # gitw push <origin> <destbranch>

    https://github.com/westurner/tools/blob/gh-pages/index.html

    https://westurner.github.io/tools/


    * RawGit:

      dev/test: https://rawgit.com/westurner/tools/gh-pages/index.html

      CDN: https://cdn.rawgit.com/westurner/tools/gh-pages/index.html

  * Output: *ReadTheDocs*:

    https://<projectname>.readthedocs.io/en/<version>/

    https://read-the-docs.readthedocs.io/en/latest/


.. glossary::

   Sphinx Builder
      A Sphinx Builder transforms :ref:`ReStructuredText` into various
      output forms:

         * HTML
         * LaTeX
         * PDF
         * ePub
         * MOBI
         * JSON
         * OpenDocument (OpenOffice)
         * Office Open XML (MS Word)

      See: `Sphinx Builders <http://sphinx-doc.org/builders.html>`_

   Sphinx ReStructuredText
      Sphinx extends :ref:`ReStructuredText` with roles and directives
      which only work with Sphinx.

   Sphinx Directive
      Sphinx extensions of :ref:`Docutils` :ref:`ReStructuredText`
directives.

      Most other ReStructuredText parsers do not support Sphinx directives.

      .. code-block:: rest

         .. toctree::

            readme
            installation
            usage

      See: `Sphinx Directives <http://sphinx-doc.org/rest.html#directives>`_

   Sphinx Role
      Sphinx extensions of :ref:`Docutils` :ref:`RestructuredText` roles

      Most other ReStructuredText parsers do not support Sphinx directives.

      .. code-block:: rest

            .. _anchor-name:

            A link to :ref:`anchor <anchor-name>`.

```

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

--00000000000079b931058735b68c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div dir=3D"ltr"><div>- Accessible, usable docs are worth something in R=
OI</div><div>=C2=A0 - <a href=3D"https://www.writethedocs.org/">https://www=
.writethedocs.org/</a></div><div>=C2=A0 - <a href=3D"https://read-the-docs.=
readthedocs.io/en/latest/">https://read-the-docs.readthedocs.io/en/latest/<=
/a></div><div>=C2=A0 - <a href=3D"https://github.com/rtfd/readthedocs-docke=
r-images/issues/47#issuecomment-485712800">https://github.com/rtfd/readthed=
ocs-docker-images/issues/47#issuecomment-485712800</a></div><div>=C2=A0=C2=
=A0=C2=A0 - Dockerfile that extends from readthedocs/build:latest (which ha=
s the GBs of latex necessary to run `make latexpdf` for all you PDF lovers =
out there)</div><div><br></div><div>- <a href=3D"https://github.com/yolosee=
m/awesome-sphinxdoc">https://github.com/yoloseem/awesome-sphinxdoc</a></div=
><div>=C2=A0 - There are various Sphinx extensions for optionally including=
 generated API docs for various languages</div><div>=C2=A0 - If you add the=
 extensions you want installed to your requirements.txt or environment.yml,=
 ReadTheDocs will install those for every build. You can also create (and m=
aintain) a custom Docker image with all of the docs building dependencies i=
nstalled (e.g. requirements_dev.txt and/or docs/requirements.txt)<br></div>=
<div><br></div><div>- <a href=3D"https://kernel.readthedocs.io/en/latest/ke=
rnel-documentation.html">https://kernel.readthedocs.io/en/latest/kernel-doc=
umentation.html</a></div><div>=C2=A0 - This says &quot;Copyright 2016&quot;=
? That&#39;s set in conf.py</div><div><br></div><div>I keep a tools doc in =
ReST:</div><div>- <a href=3D"https://westurner.github.io/tools/#sphinx">htt=
ps://westurner.github.io/tools/#sphinx</a></div><div>- <a href=3D"https://w=
esturner.github.io/tools/#docutils">https://westurner.github.io/tools/#docu=
tils</a></div><div><br></div><div>I&#39;ll just CC those sections here:</di=
v><div><br></div><div>```rst<br></div><div><br></div><div>.. index:: Docuti=
ls<br>.. _docutils:<br><br>Docutils<br>~~~~~~~~~~~~~~~~~~~<br>| Homepage: <=
a href=3D"http://docutils.sourceforge.net">http://docutils.sourceforge.net<=
/a><br>| PyPI: <a href=3D"https://pypi.python.org/pypi/docutils">https://py=
pi.python.org/pypi/docutils</a><br>| Docs: <a href=3D"http://docutils.sourc=
eforge.net/docs/">http://docutils.sourceforge.net/docs/</a><br>| Docs: <a h=
ref=3D"http://docutils.sourceforge.net/rst.html">http://docutils.sourceforg=
e.net/rst.html</a><br>| Docs: <a href=3D"http://docutils.sourceforge.net/do=
cs/ref/doctree.html">http://docutils.sourceforge.net/docs/ref/doctree.html<=
/a><br>| Docs: <a href=3D"https://docutils.readthedocs.io/en/sphinx-docs/">=
https://docutils.readthedocs.io/en/sphinx-docs/</a><br>| Docs: <a href=3D"h=
ttps://docutils.readthedocs.io/en/sphinx-docs/ref/rst/restructuredtext.html=
">https://docutils.readthedocs.io/en/sphinx-docs/ref/rst/restructuredtext.h=
tml</a><br>| Src: svn <a href=3D"http://svn.code.sf.net/p/docutils/code/tru=
nk">http://svn.code.sf.net/p/docutils/code/trunk</a><br><br>Docutils is a :=
ref:`Python` library which &#39;parses&quot; :ref:`ReStructuredText`<br>lig=
htweight markup language into a doctree (~DOM)<br>which can be serialized i=
nto<br>HTML, ePub, MOBI, LaTeX, man pages,<br>Open Document files,<br>XML, =
JSON, and a number of other formats.</div><div><br></div><div>.. index:: Sp=
hinx<br>.. _sphinx:<br><br>Sphinx<br>~~~~~~~~~~~~~~~~~<br>| Wikipedia: `&lt=
;<a href=3D"https://en.wikipedia.org/wiki/Sphinx_(documentation_generator)"=
>https://en.wikipedia.org/wiki/Sphinx_(documentation_generator)</a>&gt;`_<b=
r>| Homepage: <a href=3D"https://pypi.python.org/pypi/Sphinx">https://pypi.=
python.org/pypi/Sphinx</a><br>| Src: git <a href=3D"https://github.com/sphi=
nx-doc/sphinx">https://github.com/sphinx-doc/sphinx</a><br>| Pypi: <a href=
=3D"https://pypi.python.org/pypi/Sphinx">https://pypi.python.org/pypi/Sphin=
x</a><br>| Docs: <a href=3D"http://sphinx-doc.org/contents.html">http://sph=
inx-doc.org/contents.html</a><br>| Docs: <a href=3D"http://sphinx-doc.org/m=
arkup/code.html">http://sphinx-doc.org/markup/code.html</a><br>| Docs: <a h=
ref=3D"http://www.sphinx-doc.org/en/stable/markup/inline.html#ref-role">htt=
p://www.sphinx-doc.org/en/stable/markup/inline.html#ref-role</a><br>| Docs:=
 <a href=3D"http://pygments.org/docs/lexers/">http://pygments.org/docs/lexe=
rs/</a><br>| Docs: <a href=3D"http://thomas-cokelaer.info/tutorials/sphinx/=
rest_syntax.html">http://thomas-cokelaer.info/tutorials/sphinx/rest_syntax.=
html</a><br>| Docs: <a href=3D"https://github.com/yoloseem/awesome-sphinxdo=
c">https://github.com/yoloseem/awesome-sphinxdoc</a><br><br><br>Sphinx is a=
 tool for working with<br>:ref:`ReStructuredText` documentation trees<br>an=
d rendering them into HTML, PDF, LaTeX, ePub,<br>and a number of other form=
ats.<br><br>Sphinx extends :ref:`Docutils` with a number of useful markup b=
ehaviors<br>which are not supported by other ReStructuredText parsers.<br><=
br>Most other ReStructuredText parsers do not support Sphinx directives;<br=
>so, for example,<br><br>* GitHub and BitBucket do not support Sphinx but d=
o support ReStructuredText<br>=C2=A0 so ``README.rst`` containing Sphinx ta=
gs renders in plaintext or raises errors.<br><br>=C2=A0 For example, the in=
dex page of this<br>=C2=A0 :ref:`Sphinx` documentation set is generated fro=
m<br>=C2=A0 a file named ``index.rst`` that referenced by ``docs/conf.py``,=
<br>=C2=A0 which is utilized by ``sphinx-build`` in the ``Makefile``.<br><b=
r>=C2=A0 * Input:<br><br>=C2=A0=C2=A0=C2=A0 .. code:: bash<br><br>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 _indexrst=3D&quot;$WORKON_HOME/src/westurner/tools/in=
dex.rst&quot;<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e $_indexrst<br><br>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 # with westurner/dotfiles.venv<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mkvirtualenv westurner<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 we=
 westurner tools; mkdir -p $_SRC<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git clon=
e ssh://<a href=3D"http://git@github.com/westurner/tools">git@github.com/we=
sturner/tools</a><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cdw; e index.rst=C2=A0=
=C2=A0=C2=A0 # ew index.rst<br><br>=C2=A0=C2=A0=C2=A0 <a href=3D"https://gi=
thub.com/westurner/tools/blob/master/index.rst">https://github.com/westurne=
r/tools/blob/master/index.rst</a><br><br>=C2=A0=C2=A0=C2=A0 <a href=3D"http=
s://raw.githubusercontent.com/westurner/tools/master/index.rst">https://raw=
.githubusercontent.com/westurner/tools/master/index.rst</a><br><br><br><br>=
=C2=A0 * Output:<br><br>=C2=A0=C2=A0=C2=A0 .. code:: bash<br><br>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cd $_WRD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # cdwrd; cdw<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git statu=
s; make &lt;tab&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #=
 gitw status; makew &lt;tab&gt;<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 make html=
 singlehtml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 # make docs<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 web ./_build/html/index.h=
tml=C2=A0=C2=A0=C2=A0 # make open<br><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mak=
e gh-pages=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # ghp-import -n -p ./_build/=
html/ -b gh-pages<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 make push=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # gitw push &lt;origin&gt;=
 &lt;destbranch&gt;<br><br>=C2=A0=C2=A0=C2=A0 <a href=3D"https://github.com=
/westurner/tools/blob/gh-pages/index.html">https://github.com/westurner/too=
ls/blob/gh-pages/index.html</a><br><br>=C2=A0=C2=A0=C2=A0 <a href=3D"https:=
//westurner.github.io/tools/">https://westurner.github.io/tools/</a><br><br=
><br>=C2=A0=C2=A0=C2=A0 * RawGit:<br><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev=
/test: <a href=3D"https://rawgit.com/westurner/tools/gh-pages/index.html">h=
ttps://rawgit.com/westurner/tools/gh-pages/index.html</a><br><br>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 CDN: <a href=3D"https://cdn.rawgit.com/westurner/tool=
s/gh-pages/index.html">https://cdn.rawgit.com/westurner/tools/gh-pages/inde=
x.html</a><br><br>=C2=A0 * Output: *ReadTheDocs*:<br><br>=C2=A0=C2=A0=C2=A0=
 https://&lt;projectname&gt;.<a href=3D"http://readthedocs.io/en/">readthed=
ocs.io/en/</a>&lt;version&gt;/<br><br>=C2=A0=C2=A0=C2=A0 <a href=3D"https:/=
/read-the-docs.readthedocs.io/en/latest/">https://read-the-docs.readthedocs=
.io/en/latest/</a><br><br><br>.. glossary::<br><br>=C2=A0=C2=A0 Sphinx Buil=
der<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A Sphinx Builder transforms :ref:`ReS=
tructuredText` into various<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 output forms:=
<br><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * HTML<br>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * LaTeX<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * PDF<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * ePub<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * M=
OBI<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * JSON<br>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * OpenDocument (OpenOffice)<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Office Open XML (MS Word)<b=
r><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 See: `Sphinx Builders &lt;<a href=3D"h=
ttp://sphinx-doc.org/builders.html">http://sphinx-doc.org/builders.html</a>=
&gt;`_<br><br>=C2=A0=C2=A0 Sphinx ReStructuredText<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Sphinx extends :ref:`ReStructuredText` with roles and directives<=
br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 which only work with Sphinx.<br><br>=C2=
=A0=C2=A0 Sphinx Directive<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Sphinx extensi=
ons of :ref:`Docutils` :ref:`ReStructuredText` directives.<br><br>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Most other ReStructuredText parsers do not support Sp=
hinx directives.<br><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .. code-block:: rest=
<br><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .. toctree::<br><b=
r>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 readme=
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inst=
allation<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 usage<br><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 See: `Sphinx Directives &lt=
;<a href=3D"http://sphinx-doc.org/rest.html#directives">http://sphinx-doc.o=
rg/rest.html#directives</a>&gt;`_<br><br>=C2=A0=C2=A0 Sphinx Role<br>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Sphinx extensions of :ref:`Docutils` :ref:`Restruc=
turedText` roles<br><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Most other ReStructu=
redText parsers do not support Sphinx directives.<br><br>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 .. code-block:: rest<br><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .. _anchor-name:<br><br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A link to :ref:`anchor =
&lt;anchor-name&gt;`.<br></div><div><br></div><div>```<br></div></div></div=
></div></div></div></div></div></div></div></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 23, 2019 at 12:31 PM=
 Jonathan Corbet &lt;<a href=3D"mailto:corbet@lwn.net">corbet@lwn.net</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue=
, 23 Apr 2019 15:01:32 +0200<br>
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

--00000000000079b931058735b68c--

--===============4179755425576992558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4179755425576992558==--
