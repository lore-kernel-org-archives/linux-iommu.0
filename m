Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E456C5235
	for <iommu@lists.linux.dev>; Sun, 13 Aug 2023 13:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
	:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=32c6Mm00cywxiQeEBwm2QcUwjGNrZK2x4F4KY6NgXho=; b=E7FGsiYTH3wPJ7Tmf2adP5WNyD
	Cvv102lMqPh9YoKqH5L2ogeYt3RCS2/hUkkZmskEj/JhuCoRmRcYpUFYybYargIzOnUfDWxaKr7/6
	BYnAc/XGL+tHscgWuishetwlPG+GvANno729NutZ85R/sTfZdPkcIW0gYb6oPtmjWi1MXvTcU3Bwj
	BTG1b3+mCaL4yvhQa3qasMCnEzFKCYDaR2jatUnmC5o7dABQ/yvuTOqFuqJG1cSLJ5+9DoJWrvW9F
	VtM/QAkcsu1UHGbFxCJY+K9U2GojcUcSxiuU5Kr2Q5VX+tW4s/oBZhhS9vTjAJS3o/M3w40N5OeY5
	eeYHjumQ==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
	(envelope-from <dg@treblig.org>)
	id 1qVAvC-006cZ6-8i; Sun, 13 Aug 2023 13:14:18 +0000
Date: Sun, 13 Aug 2023 13:14:18 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Regression: v4l/bttv vbi vs iommu
Message-ID: <ZNjXKjCx3lH0s1m3@gallifrey>
References: <Y9qSwkLxeMpffZK/@gallifrey>
 <d363902d-e465-8411-0c1e-58411b3a19b0@xs4all.nl>
 <20230203063500.GA23520@lst.de>
 <3a59ffba-a7fe-97b0-af76-7194f7b3896a@xs4all.nl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3a59ffba-a7fe-97b0-af76-7194f7b3896a@xs4all.nl>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 13:14:01 up 37 days, 22:45,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)

* Hans Verkuil (hverkuil@xs4all.nl) wrote:
> On 03/02/2023 07:35, Christoph Hellwig wrote:
> > On Wed, Feb 01, 2023 at 09:48:46PM +0100, Hans Verkuil wrote:
> >> In fact, the plan is to replace the old and deprecated videobuf framework by the vb2
> >> framework in the bttv driver in the next 2-3 months or so. That will also automatically
> >> solve this problem.
> > 
> > It would be great to expedite removal of the old videbuf code given
> > how many problems it has.
> 
> We're working on it. A lot of old drivers in drivers/staging/media/deprecated will
> be removed in 6.3, and that leaves the cx18, bttv and saa7146 drivers that still use
> vb1.
> 
> This week I posted patches converting cx18 to vb2 and someone else will work on the
> bttv conversion. We thought we could remove saa7146 as well, but it turns out that
> that is still very much in use (somewhat unexpectedly), so I plan to convert that
> one this month (I hope).
> 
> I aim for removing vb1 in kernel 6.4 or 6.5.

Did this go in, I'm happy to give it a go if this is a world to test.

Dave

> Regards,
> 
> 	Hans
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
