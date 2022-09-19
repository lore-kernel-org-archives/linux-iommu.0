Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1FAA45;
	Mon, 19 Sep 2022 08:31:56 +0000 (UTC)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1oaCC1-0003Xw-MT; Mon, 19 Sep 2022 10:31:53 +0200
Message-ID: <332ef1c8-2d83-f0ec-74b6-d485f5b15c2e@leemhuis.info>
Date: Mon, 19 Sep 2022 10:31:53 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: 5.19.9 regression: DMAR error on i7-8650U #forregzbot
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux1394-devel@lists.sourceforge.net"
 <linux1394-devel@lists.sourceforge.net>
References: <485A6EA5-6D58-42EA-B298-8571E97422DE@getmailspring.com>
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <485A6EA5-6D58-42EA-B298-8571E97422DE@getmailspring.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1663576317;f2016df4;
X-HE-SMSGID: 1oaCC1-0003Xw-MT

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.

On 18.09.22 02:00, George Hilliard wrote:
> I'm experiencing a regression on 5.19.9 from 5.19.8. Not sure if you are
> already aware of this, apologies if it's noise.  My hunch is that this
> is an iommu problem since there were quite a few iommu changes in .9,
> but I have also Cc'd Firewire maintainers on the chance that I'm wrong.
> 
> My Apple Thunderbolt to Firewire adapter has quit working on 5.19.9 on
> my Thinkpad T480s (i7-8650U), with the following log message while
> enumerating the device (reformatted for email):
> 
>     [  318.263546] thunderbolt 0-1: new device found, vendor=0x1 device=0x8004
>     [  318.263559] thunderbolt 0-1: Apple, Inc. Thunderbolt to FireWire Adapter
>     [  318.342416] pcieport 0000:05:01.0: pciehp: Slot(1): Card present
>     [  318.342428] pcieport 0000:05:01.0: pciehp: Slot(1): Link Up
>     (snip)
>     [  318.503177] pcieport 0000:08:00.0: enabling device (0000 -> 0003)
>     [  318.504976] firewire_ohci 0000:09:00.0: enabling device (0000 -> 0002)
>     [  318.562000] firewire_ohci 0000:09:00.0: added OHCI v1.10 device
>                    as card 4, 8 IR + 8 IT contexts, quirks 0x0, physUB
>     [  318.562109] DMAR: DRHD: handling fault status reg 2
>     [  318.562114] DMAR: [INTR-REMAP] Request device [09:00.0] fault
>                    index 0x8080 [fault reason 0x25] Blocked a
>                    compatibility format interrupt request
> 
> The last two lines are the new error.
> 
> Happy to provide more details or experiment; this happens nearly every time.

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot introduced v5.19.8..v5.19.9 ^
https://bugzilla.kernel.org/show_bug.cgi?id=216497
#regzbot title iommu: DMAR errors
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
