Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9BE1367;
	Mon, 26 Dec 2022 13:29:41 +0000 (UTC)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1p9nXv-0006WF-Vk; Mon, 26 Dec 2022 14:29:40 +0100
Message-ID: <4eac7a29-fed2-6493-a604-17fcba2a13ba@leemhuis.info>
Date: Mon, 26 Dec 2022 14:29:39 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix PCI device reference count leak in
 has_external pci() #forregzbot
Content-Language: en-US, de-DE
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: iommu@lists.linux.dev
References: <D41A3A42-2412-4722-9090-01565058E525@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <D41A3A42-2412-4722-9090-01565058E525@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672061381;1b4ccdef;
X-HE-SMSGID: 1p9nXv-0006WF-Vk

[Note: this mail contains only information for Linux kernel regression
tracking. Mails like these contain '#forregzbot' in the subject to make
then easy to spot and filter out. The author also tried to remove most
or all individuals from the list of recipients to spare them the hassle.]

On 25.12.22 13:11, Zeno Davatz wrote:
> Hi
> 
> I am getting this hang with kernel 6.1. See attachment.
> 
> Is this related to your patch?
> 
> Kernel 6.1 does not boot for me. Kernel 6.0 was fine.
> 
> Thank you for your reply.

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced v6.0..v6.1-rc1
#regzbot title pci(?)/iommu(?): hang with kernel 6.1
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
