Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B81C27;
	Mon, 13 Mar 2023 06:29:37 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pbbgb-0001YD-La; Mon, 13 Mar 2023 07:29:33 +0100
Message-ID: <718be161-4656-7900-a317-b06d05552bb4@leemhuis.info>
Date: Mon, 13 Mar 2023 07:29:32 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/3] iommu: Attach device group to old domain in error
 path
Content-Language: en-US, de-DE
To: Vasant Hegde <vasant.hegde@amd.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 iommu@lists.linux.dev, joro@8bytes.org, baolu.lu@linux.intel.com
Cc: suravee.suthikulpanit@amd.com, robin.murphy@arm.com, will@kernel.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Matt Fagnani <matt.fagnani@bell.net>
References: <20230215052642.6016-1-vasant.hegde@amd.com>
 <0f6e2838-9d7f-dc2c-6e5b-0d02e239f032@amd.com>
 <c44b3f40-4b8f-8614-65f5-e78ded89c641@leemhuis.info>
 <855144db-5952-04d2-abbf-d821dd8ba25c@amd.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <855144db-5952-04d2-abbf-d821dd8ba25c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678688977;0a29d822;
X-HE-SMSGID: 1pbbgb-0001YD-La

On 13.03.23 05:29, Vasant Hegde wrote:
> Hi Thorsten,
> 
> As i described in other thread [1] it looks like GPU needs to handle failure in
> resume path.
>
> [1]
> https://lore.kernel.org/linux-iommu/9b688cbe-ec48-17a7-0e40-5734d58e102d@amd.com/T/#t

Thx for that, sorry, I had missed that other thread for some reason (I
really wonder why, I know I looked if Matt reported this to the list,
but seems I missed it somehow; whatever).

Ciao, Thorsten
