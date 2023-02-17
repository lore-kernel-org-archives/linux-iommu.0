Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C4963E;
	Fri, 17 Feb 2023 06:11:36 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pSty1-0005Vo-7a; Fri, 17 Feb 2023 07:11:33 +0100
Message-ID: <b25da864-7227-e669-30fa-d953da252842@leemhuis.info>
Date: Fri, 17 Feb 2023 07:11:32 +0100
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
 <7c8a2356-4964-20a7-2f8b-4836c1f6a9ff@leemhuis.info>
 <d3d6aff3-b10e-4d02-65f6-b714ad57bd78@amd.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <d3d6aff3-b10e-4d02-65f6-b714ad57bd78@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676614296;838a7391;
X-HE-SMSGID: 1pSty1-0005Vo-7a

On 17.02.23 06:56, Vasant Hegde wrote:
> On 2/16/2023 3:11 PM, Thorsten Leemhuis wrote:
>> On 15.02.23 06:26, Vasant Hegde wrote:
>>> If IOMMU domain for device group is not setup properly then we may hit
>>> IOMMU page fault. Current page fault handler assumes that domain is
>>> always setup and it will hit NULL pointer derefence (see below sample log).
>>>
>>> Lets check whether domain is setup or not and log appropriate message.
>>>
>>> [...]
>>
>> Many thx for taking care of this. Is this something that is still
>> suitable for merging before 6.2 is released? If not it would be good to
>> directly add a "CC: <stable.." tag to ensure it's backported to 6.2
>> later, as maybe there are more people affected by this.
> 
> I think patch 1/3 is candidate for 6.2. I have request Joerg to look into it.

Great, many thx for clarifying. Sorry for creating confusion, I
sometimes get details wrong, as I juggle with so many different
regression at the same time...

>>> Reported-by: Matt Fagnani <matt.fagnani@bell.net>
>>
>> There is one small thing to improve, please add the following tags here
>> to make things easier for future code archaeologists:
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
>> Link:
>> https://lore.kernel.org/lkml/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/
>>
> 
> I am sorry. I should have added above two links. I will keep a note so that I
> don't miss things next time.
> 
> Joerg did added these link before applying. Thanks Joerg.

+1

Ciao, Thorsten
