Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1615A8;
	Mon, 13 Mar 2023 10:30:14 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pbfRT-0000zy-Qi; Mon, 13 Mar 2023 11:30:11 +0100
Message-ID: <aef0902c-ef9a-c959-7786-d7362e15471a@leemhuis.info>
Date: Mon, 13 Mar 2023 11:30:09 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: amdgpu failed to resume with AMD IOMMU enabled and 6.2.2-301 and
 6.3.0-0.rc0.20230227gitf3a2439f20d9.9.fc39 and later resulting in a black
 screen
Content-Language: en-US, de-DE
To: Matt Fagnani <matt.fagnani@bell.net>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <4a3b225c-2ffd-e758-4de1-447375e34cad@bell.net>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <4a3b225c-2ffd-e758-4de1-447375e34cad@bell.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678703414;e7250bfd;
X-HE-SMSGID: 1pbfRT-0000zy-Qi

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 11.03.23 19:57, Matt Fagnani wrote:
> I booted a Fedora 38 KDE Plasma installation with the 6.2.2-301 kernel
> on an hp laptop with an AMD A10-9620P CPU, an integrated Radeon R5 GPU,
> and an AMD IOMMU enabled. I selected Sleep in either the Application
> Launcher menu in Plasma 5.27.2 on Wayland or sddm on Wayland. The system
> went to sleep. I moved the mouse to wake the system. The screen remained
> black, but the LEDs on the side of the laptop flickered indicating drive
> activity and the fan resumed making noise. I pressed sysrq+alt+s,u,b to
> do an emergency sync, remount read-only, and reboot. The system
> rebooted. The journal indicated the amdgpu failed to resume due to
> errors including amdgpu: amdgpu_device_ip_resume failed (-6). which
> started after the kernel failed to resume the AMD IOMMU.
> [...]
Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot (note, the version number is not entirely correct, but
things are a bit tricky here, but that version doesn't matter much
anyway in this case):

#regzbot ^introduced v6.1..v6.3-rc
https://bugzilla.kernel.org/show_bug.cgi?id=217170
#regzbot title amdgpu/iommu/: failed to resume
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
