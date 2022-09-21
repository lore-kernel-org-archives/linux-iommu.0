Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216177C;
	Wed, 21 Sep 2022 08:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C885C433D6;
	Wed, 21 Sep 2022 08:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1663749733;
	bh=0GtndUAX9QGEdlFlTyfog2IdLqe1o69t51NBUAd7SDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K71vEzCNwiodN3DboG0aaQ9oEql1VhmGWZg5kQbM0v51hdhJWh1iH+F87q/1QhWGg
	 YjSsqqjVhYAzOkMK5B8ciBzjQvrlPM6EXa2QomNyl0DDsi1R+yvi9c9gSFRtfX7nx+
	 LHr+573awWCWsDUYBzAkymQoCtLcwhmR5ShpmXSQ=
Date: Wed, 21 Sep 2022 10:42:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: How to quickly resolve the IOMMU regression that currently
 plagues a lot of people in 5.19.y
Message-ID: <YyrOYnneEH/lS+n0@kroah.com>
References: <1d1844f0-c773-6222-36c6-862e14f6020d@leemhuis.info>
 <fd672632-7935-14ff-e2be-0db8443b0907@leemhuis.info>
 <YyrI/qzx/EWapzck@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyrI/qzx/EWapzck@8bytes.org>

On Wed, Sep 21, 2022 at 10:19:10AM +0200, Joerg Roedel wrote:
> Hi Thorsten,
> 
> On Wed, Sep 21, 2022 at 09:15:17AM +0200, Thorsten Leemhuis wrote:
> > [resend with proper subject, sorry for the noise]
> 
> Thanks for the noise :) I will queue the fix today and send it upstream.

Great, thanks for doing this.

greg k-h
