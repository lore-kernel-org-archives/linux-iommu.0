Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241A2C9D
	for <iommu@lists.linux.dev>; Sun, 13 Aug 2023 13:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4252CC433C7;
	Sun, 13 Aug 2023 13:44:19 +0000 (UTC)
Message-ID: <8a667bd9-6a2d-301c-ee11-23e9466b193a@xs4all.nl>
Date: Sun, 13 Aug 2023 15:44:17 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Regression: v4l/bttv vbi vs iommu
Content-Language: en-US, nl
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
 mchehab@kernel.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y9qSwkLxeMpffZK/@gallifrey>
 <d363902d-e465-8411-0c1e-58411b3a19b0@xs4all.nl>
 <20230203063500.GA23520@lst.de>
 <3a59ffba-a7fe-97b0-af76-7194f7b3896a@xs4all.nl> <ZNjXKjCx3lH0s1m3@gallifrey>
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <ZNjXKjCx3lH0s1m3@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/08/2023 15:14, Dr. David Alan Gilbert wrote:
> * Hans Verkuil (hverkuil@xs4all.nl) wrote:
>> On 03/02/2023 07:35, Christoph Hellwig wrote:
>>> On Wed, Feb 01, 2023 at 09:48:46PM +0100, Hans Verkuil wrote:
>>>> In fact, the plan is to replace the old and deprecated videobuf framework by the vb2
>>>> framework in the bttv driver in the next 2-3 months or so. That will also automatically
>>>> solve this problem.
>>>
>>> It would be great to expedite removal of the old videbuf code given
>>> how many problems it has.
>>
>> We're working on it. A lot of old drivers in drivers/staging/media/deprecated will
>> be removed in 6.3, and that leaves the cx18, bttv and saa7146 drivers that still use
>> vb1.
>>
>> This week I posted patches converting cx18 to vb2 and someone else will work on the
>> bttv conversion. We thought we could remove saa7146 as well, but it turns out that
>> that is still very much in use (somewhat unexpectedly), so I plan to convert that
>> one this month (I hope).
>>
>> I aim for removing vb1 in kernel 6.4 or 6.5.
> 
> Did this go in, I'm happy to give it a go if this is a world to test.

I just merged it for 6.6.

Regards,

	Hans

