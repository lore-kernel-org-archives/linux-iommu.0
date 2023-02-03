Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B679F7F
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 06:35:04 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 57D1F68C4E; Fri,  3 Feb 2023 07:35:00 +0100 (CET)
Date: Fri, 3 Feb 2023 07:35:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, iommu@lists.linux.dev,
	mchehab@kernel.org, hch@lst.de, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Regression: v4l/bttv vbi vs iommu
Message-ID: <20230203063500.GA23520@lst.de>
References: <Y9qSwkLxeMpffZK/@gallifrey> <d363902d-e465-8411-0c1e-58411b3a19b0@xs4all.nl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d363902d-e465-8411-0c1e-58411b3a19b0@xs4all.nl>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 01, 2023 at 09:48:46PM +0100, Hans Verkuil wrote:
> In fact, the plan is to replace the old and deprecated videobuf framework by the vb2
> framework in the bttv driver in the next 2-3 months or so. That will also automatically
> solve this problem.

It would be great to expedite removal of the old videbuf code given
how many problems it has.
