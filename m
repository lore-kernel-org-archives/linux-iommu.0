Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468B7B;
	Thu, 16 Feb 2023 09:42:01 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pSam6-00044m-EV; Thu, 16 Feb 2023 10:41:58 +0100
Message-ID: <7c8a2356-4964-20a7-2f8b-4836c1f6a9ff@leemhuis.info>
Date: Thu, 16 Feb 2023 10:41:57 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 3/3] iommu/amd: Improve page fault error reporting
Content-Language: en-US, de-DE
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org, baolu.lu@linux.intel.com
Cc: suravee.suthikulpanit@amd.com, robin.murphy@arm.com, will@kernel.org,
 Matt Fagnani <matt.fagnani@bell.net>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230215052642.6016-1-vasant.hegde@amd.com>
 <20230215052642.6016-3-vasant.hegde@amd.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20230215052642.6016-3-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676540521;bfe5a8a2;
X-HE-SMSGID: 1pSam6-00044m-EV

On 15.02.23 06:26, Vasant Hegde wrote:
> If IOMMU domain for device group is not setup properly then we may hit
> IOMMU page fault. Current page fault handler assumes that domain is
> always setup and it will hit NULL pointer derefence (see below sample log).
> 
> Lets check whether domain is setup or not and log appropriate message.
>
> [...]

Many thx for taking care of this. Is this something that is still
suitable for merging before 6.2 is released? If not it would be good to
directly add a "CC: <stable.." tag to ensure it's backported to 6.2
later, as maybe there are more people affected by this.

> Reported-by: Matt Fagnani <matt.fagnani@bell.net>

There is one small thing to improve, please add the following tags here
to make things easier for future code archaeologists:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
Link:
https://lore.kernel.org/lkml/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/

To explain: Linus[1] and others considered proper link tags with the URL
to the report important, as they allow anyone to look into the backstory
of a fix weeks or years later. That's nothing new, the documentation[2]
for some time says to place such tags in cases like this. I care
personally (and made it a bit more explicit in the docs a while ago),
because these tags make my regression tracking efforts a whole lot
easier, as they allow my tracking bot 'regzbot' to automatically connect
reports with patches posted or committed to fix tracked regressions.

Apropos regzbot, let me tell regzbot to monitor this thread:

#regzbot ^backmonitor:
https://lore.kernel.org/lkml/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/

> Suggested-by: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> [...]

/me wonders if this also should have a Fixes: tag.


Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

[1] for details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

[2] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)

--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
