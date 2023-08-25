Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F193C2D5
	for <iommu@lists.linux.dev>; Fri, 25 Aug 2023 08:57:07 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aeea0.dynamic.kabel-deutschland.de [95.90.238.160])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4DAED61E5FE04;
	Fri, 25 Aug 2023 10:49:52 +0200 (CEST)
Message-ID: <e424716f-1290-4434-9e37-ed0c6a264dfd@molgen.mpg.de>
Date: Fri, 25 Aug 2023 10:49:51 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Thinkpad T14s Gen 3 (AMD): Fingerprint reader stops working with
 disabled IOMMU
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: =?UTF-8?Q?J=C3=B6rg_Roedel?= <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Pavel Valach <valach.pavel@gmail.com>,
 Mark Pearson <markpearson@lenovo.com>,
 Mario Limonciello <mario.limonciello@amd.com>, iommu@lists.linux.dev
References: <7aa5c5f2-b60c-4aba-b03c-45c5d2672194@molgen.mpg.de>
In-Reply-To: <7aa5c5f2-b60c-4aba-b03c-45c5d2672194@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Fix list address to iommu@lists.linux.dev]

Am 25.08.23 um 10:25 schrieb Paul Menzel:
> Dear Linux folks,
> 
> 
> No idea where to report this to. In the Mesa issue tracker, Pavel Valach 
> reports [1]:
> 
>> On my Thinkpad T14s Gen 3 (AMD), the Goodix fingerprint reader
>> (27c6:6594) stopped working under Linux since I disabled IOMMU via
>> kernel command line args. I'll try the pgtbl_v2.
> 
> Pavel, would you be so kind to attach the Linux logs with IOMMU enabled 
> and working fingerprint reader and one with disabled IOMMU?
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://gitlab.freedesktop.org/mesa/mesa/-/issues/8044#note_2058621
