Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF9D7F
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 08:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F36C433D2;
	Fri,  3 Feb 2023 08:05:33 +0000 (UTC)
Message-ID: <3a59ffba-a7fe-97b0-af76-7194f7b3896a@xs4all.nl>
Date: Fri, 3 Feb 2023 09:05:31 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Regression: v4l/bttv vbi vs iommu
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, iommu@lists.linux.dev,
 mchehab@kernel.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y9qSwkLxeMpffZK/@gallifrey>
 <d363902d-e465-8411-0c1e-58411b3a19b0@xs4all.nl>
 <20230203063500.GA23520@lst.de>
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230203063500.GA23520@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/02/2023 07:35, Christoph Hellwig wrote:
> On Wed, Feb 01, 2023 at 09:48:46PM +0100, Hans Verkuil wrote:
>> In fact, the plan is to replace the old and deprecated videobuf framework by the vb2
>> framework in the bttv driver in the next 2-3 months or so. That will also automatically
>> solve this problem.
> 
> It would be great to expedite removal of the old videbuf code given
> how many problems it has.

We're working on it. A lot of old drivers in drivers/staging/media/deprecated will
be removed in 6.3, and that leaves the cx18, bttv and saa7146 drivers that still use
vb1.

This week I posted patches converting cx18 to vb2 and someone else will work on the
bttv conversion. We thought we could remove saa7146 as well, but it turns out that
that is still very much in use (somewhat unexpectedly), so I plan to convert that
one this month (I hope).

I aim for removing vb1 in kernel 6.4 or 6.5.

Regards,

	Hans
