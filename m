Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911C437D
	for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 14:40:34 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fc02a92dcfso40427475e9.0
        for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20221208.gappssmtp.com; s=20221208; t=1689086432; x=1691678432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhzfiy+hPv0xsgJj8yvinve0G66Qt5ZrlIlGwcPKaMA=;
        b=wQMgcTk+sYBVQSKvqZS2EU0Nclo5V2QGycAZRd9iihJAAg5ff679RK4upNANkYx7d+
         Ox5E4m9+570jJ2/oDvRYFrR7CHBFJ48GwrQtDbd1fLcqJkrdWhRNFhD7k44edpNa/AD9
         BDup0g8wi/d13nVPsI1KQ1dtV1SszzPQh762nN19y7ChS4MT93U3TPh8nomkfVPiz2bv
         Bg6xIK4BpXRNMhZFPx1n746wxF8HBkpCEMC2uKes5lpBM7l3kKvxx6zjvsdVsBAacKmO
         xAkCz3TsIdAs7JjmhzkQrT3RbGxyGn+EuX7IyHz4RSX4UuesH1iVeCgjHSWuREMzhSoA
         Wycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086432; x=1691678432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhzfiy+hPv0xsgJj8yvinve0G66Qt5ZrlIlGwcPKaMA=;
        b=XuRdQtEOF9dvw5o/d2sT0lWAH2rnrMeAHOR0gAGV68mUCmEwxE8u12A3vQ2lQsJCyC
         MTwyRpSlYs7GNOwVZHVdjgGippFklOy04aG2OopGqzoFtw1+AnC0ra0I/x6V14VPTnJE
         ZU/Le5aULgJZ6m+vBbxncfXkJTmoPAerkpijpbbDZb4dzxGW7EXep+bnnLPlcemf05ak
         iHEg2oxg9KJBeBWdkiNM8427OXBTgeM3DpS/+qBQ2bbWpC9Nb0UM6Q7WlW1WcJXpt631
         bEIyJZHyO+1t5KY7+yKqRtEZVq4ZqKKr3ar7d5Wv2ZMjxJGrnsgAluGsoOz3cl9lASie
         VZeg==
X-Gm-Message-State: ABy/qLZK0CdT1QoNNNnGK9Q8kyIdOu5MY6e37UkL3DwO6NwJKs1jXqda
	kJ+8eClCUfJDE64AvIFkGwXWJ0OO1+duPm0mZYyj4w==
X-Google-Smtp-Source: APBJJlGiY50eZpre8FywirKQqTOcqIbDJXKpKXStAo4IC4QBUTLFH2ILmO21G6uLIT0yFCMV1IhpD8jyVUbXCkM7iKo=
X-Received: by 2002:a7b:cc81:0:b0:3fc:472:d1e9 with SMTP id
 p1-20020a7bcc81000000b003fc0472d1e9mr9458260wma.23.1689086432404; Tue, 11 Jul
 2023 07:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
 <20230426141520.0caf4386@meshulam.tesarici.cz> <2023042617-wobble-enlighten-9361@gregkh>
 <20230426144439.5674f8bc@meshulam.tesarici.cz> <20230509091635.27450bd9@meshulam.tesarici.cz>
 <2023050949-grueling-verify-a43b@gregkh> <CAHbf0-HY0-u4MwgU39b53hjOM+bWfGmOEYQuvHARjV+6j+O7Kg@mail.gmail.com>
 <20230711110325.2521472c@meshulam.tesarici.cz> <CAHbf0-FjiOAMHjh-7D_6gvS+oHr2tGKJArnYu=0AKYHbD8Ntrw@mail.gmail.com>
 <20230711152145.7372af4a@meshulam.tesarici.cz>
In-Reply-To: <20230711152145.7372af4a@meshulam.tesarici.cz>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 11 Jul 2023 15:40:20 +0100
Message-ID: <CAHbf0-Ey0k+B22a9guYksL7UuWfTV9hF8Zh+VWzR2iQKGh2KiA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Allow dynamic allocation of software IO TLB bounce buffers
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, Petr Tesarik <petrtesarik@huaweicloud.com>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jul 2023 at 14:21, Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wro=
te:
>
> On Tue, 11 Jul 2023 12:29:44 +0100
> Mike Lothian <mike@fireburn.co.uk> wrote:
>
> > On Tue, 11 Jul 2023 at 10:03, Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>=
 wrote:
> > >
> > > On Mon, 10 Jul 2023 23:23:45 +0100
> > > Mike Lothian <mike@fireburn.co.uk> wrote:
> > >
> > > > Hi
> > > >
> > > > I was hoping this might land for 6.5-rc1, is there a new version th=
at
> > > > might apply against 6.5?
> > >
> > > Yes, there is a v3, which is a complete rewrite based on feedback fro=
m
> > > various people on this mailing list:
> > >
> > > https://lore.kernel.org/linux-iommu/cover.1687859323.git.petr.tesarik=
.ext@huawei.com/T/
> > >
> > > Petr T
> > >
> >
> >
> > Patch 2 doesn't apply cleanly for me on 6.5-rc1
>
> Ah, right. I'm going to rebase the series and include a few other
> suggested changes.
>
> I'm a bit worried that Christoph and all other maintainers (all taken
> back into Cc) have stayed silent about the v3 series.
>
> @Christoph: Are uncomfortable with something in the idea itself, or are
> you just busy with other things?
>
> Petr T

I imagine once 6.4 starts appearing in distros there will be more bugs
appearing when people's wifi disconnects

If this is being delayed until 6.6 would it be better to increase the
default number, perhaps based on how much memory the system has and
maybe back port the fix?
