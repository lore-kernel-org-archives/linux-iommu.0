Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B093237;
	Wed, 21 Sep 2022 16:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6FBC433C1;
	Wed, 21 Sep 2022 16:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1663778813;
	bh=KO9/J/hUO8nnDy0M9Goj6pDfKn66gCx4G05aBn2ANZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RN2hmiXX6cjXziPtgx/iY5Bg3NETvDCbt4S2Wzy7zoVkAJdavITiNaLB1cvE496Bx
	 CYgB99QgC/PxyHvdNBH+yBkuwQ0K1iAEfnh+XB0e4UWAsqKMkwAz75u0Qzoyz47vLz
	 J3CiO5nwbNX1P3MO9yW0lSVSIDxsnJfC861Hw9iU=
Date: Wed, 21 Sep 2022 18:46:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: How to quickly resolve the IOMMU regression that currently
 plagues a lot of people in 5.19.y
Message-ID: <Yys/+yXuINceZGbz@kroah.com>
References: <1d1844f0-c773-6222-36c6-862e14f6020d@leemhuis.info>
 <fd672632-7935-14ff-e2be-0db8443b0907@leemhuis.info>
 <YyrI/qzx/EWapzck@8bytes.org>
 <CAHk-=wgU0PyYHut+8zV+kNCxOZiCXd5J29Eisiy8badzsk8Msw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgU0PyYHut+8zV+kNCxOZiCXd5J29Eisiy8badzsk8Msw@mail.gmail.com>

On Wed, Sep 21, 2022 at 09:15:12AM -0700, Linus Torvalds wrote:
> On Wed, Sep 21, 2022 at 1:19 AM Joerg Roedel <joro@8bytes.org> wrote:
> >
> > Thanks for the noise :) I will queue the fix today and send it upstream.
> 
> .. and it's in my tree now.

And now added to the next 5.19-rc release that is out for review now.

thanks for the quick response everyone,

greg k-h
