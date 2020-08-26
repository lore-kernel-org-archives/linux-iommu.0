Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4A4C433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 08:04:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87C5207DF
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 08:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MmIkPwve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87C5207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9A2B48689C;
	Wed, 26 Aug 2020 08:04:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3KDRTzg0vFre; Wed, 26 Aug 2020 08:04:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0EC42866F2;
	Wed, 26 Aug 2020 08:04:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2B3FC07FF;
	Wed, 26 Aug 2020 08:04:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D141CC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 08:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A23552002B
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 08:04:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nb23-W+8vYKt for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 08:03:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by silver.osuosl.org (Postfix) with ESMTPS id BF7DF22855
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 08:03:28 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1598429008; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=hleoJnRPFgTh4Q3Z/gEZpKKg+hswZ9iuwWfl1+U3mJY=;
 b=MmIkPwvevIIj/ljq4kRXDe4FhwwdaTs3gMLArsWrzoXlPBW5kWpE6pJYkVpU51Pon1UlLYJL
 vzKgrL4y5HA4/HA6oawtnLutBpQfjkMv/VeH3ZpeBZ4uuggjq8bhk3RDXtz2DZLsvz1bPpfu
 XRNcWXbjP+rjSqRYcx2lBoK5hjA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f46174f4bd493d13ebc7ef6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 26 Aug 2020 08:03:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 7818CC433A0; Wed, 26 Aug 2020 08:03:26 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 9896FC433CA;
 Wed, 26 Aug 2020 08:03:24 +0000 (UTC)
MIME-Version: 1.0
Date: Wed, 26 Aug 2020 13:33:24 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] iommu: Add support to filter non-strict/lazy mode based
 on device names
In-Reply-To: <CAD=FV=X=3Jae7_gXN_05EsmZjrM1bN=TMZ0qoGKz=UaNrthzAg@mail.gmail.com>
References: <20200825154249.20011-1-saiprakash.ranjan@codeaurora.org>
 <CAD=FV=XK3Xa3rRWvuSA_jA+5_1XYBmHEX2B2XSb8h3oOe1PHLw@mail.gmail.com>
 <3df7edd53ebca00be288e69b92b8d4b9@codeaurora.org>
 <CAD=FV=X=3Jae7_gXN_05EsmZjrM1bN=TMZ0qoGKz=UaNrthzAg@mail.gmail.com>
Message-ID: <4224f8580d19e9a7eae80299fa2ffa37@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Rajat Jain <rajatja@google.com>, Will Deacon <will@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
 iommu@lists.linux-foundation.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On 2020-08-26 03:45, Doug Anderson wrote:
> Hi,
> 
> On Tue, Aug 25, 2020 at 12:01 PM Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>> 
>> Hi,
>> 
>> On 2020-08-25 21:40, Doug Anderson wrote:
>> > Hi,
>> >
>> > On Tue, Aug 25, 2020 at 8:43 AM Sai Prakash Ranjan
>> > <saiprakash.ranjan@codeaurora.org> wrote:
>> >>
>> >> Currently the non-strict or lazy mode of TLB invalidation can only be
>> >> set
>> >> for all or no domains. This works well for development platforms where
>> >> setting to non-strict/lazy mode is fine for performance reasons but on
>> >> production devices, we need a more fine grained control to allow only
>> >> certain peripherals to support this mode where we can be sure that it
>> >> is
>> >> safe. So add support to filter non-strict/lazy mode based on the
>> >> device
>> >> names that are passed via cmdline parameter "iommu.nonstrict_device".
>> >>
>> >> Example:
>> >> iommu.nonstrict_device="7c4000.sdhci,a600000.dwc3,6048000.etr"
> 
> Just curious: are device names like this really guaranteed to be
> stable across versions?
> 

Good question, AFAIK the device names are based on the DT node address 
and
the node name, for ex:  etr@6048000 and device name - "6048000.etr", now 
I
believe these are pretty stable for a particular SoC or board since 
there
is no reason to change the device node name or the address unless 
something
has gone terribly wrong. I don't know about ACPI systems, but however 
they
are described can be specified in this command line parameter. This is 
an
advantage over the DT property where ACPI systems get left out unless 
someone
goes and adds the same/similar property over there.

> 
>> > I have an inherent dislike of jamming things like this onto the
>> > command line.  IMHO the command line is the last resort for specifying
>> > configuration and generally should be limited to some specialized
>> > debug options and cases where the person running the kernel needs to
>> > override a config that was set by the person (or company) compiling
>> > the kernel.  Specifically, having a long/unwieldy command line makes
>> > it harder to use for the case when an end user actually wants to use
>> > it to override something.  It's also just another place to look for
>> > config.
>> >
>> 
>> Good thing about command line parameters are that they are optional,
>> they do
>> not specify any default behaviour (I mean they are not mandatory to be
>> set
>> for the system to be functional), so I would like to view it as an
>> optional
>> config. And this command line parameter (nonstrict_device) is strictly
>> optional
>> with default being strict already set in the driver.
>> 
>> They can be passed from the bootloader via chosen node for DT 
>> platforms
>> or choose
>> a new *bootconfig* as a way to pass the cmdline but finally it does 
>> boil
>> down to
>> just another config.
> 
> Never looked at bootconfig.  Unfortunately it seems to require
> initramfs so that pretty much means it's out for my usage.  :(
> 

Yes that won't fit everywhere.

> 
>> I agree with general boolean or single value command line parameters
>> being just
>> more messy which could just be Kconfigs instead but for multiple value
>> parameters
>> like these do not fit in Kconfig.
>> 
>> As you might already know, command line also gives an advantage to the
>> end user
>> to configure system without building kernel, for this specific command
>> line its
>> very useful because the performance bump is quite noticeable when the
>> iommu.strict
>> is off. Now for end user who would not be interested in building 
>> entire
>> kernel(majority)
>> and just cares about good speeds or throughput can find this very
>> beneficial.
>> I am not talking about one specific OS usecase here but more in 
>> general
>> term.
>> 
>> > The other problem is that this doesn't necessarily scale very well.
>> > While it works OK for embedded cases it doesn't work terribly well for
>> > distributions.  I know that in an out-of-band thread you indicated
>> > that it doesn't break anything that's not already broken (AKA this
>> > doesn't fix the distro case but it doesn't make it worse), it would be
>> > better to come up with a more universal solution.
>> >
>> 
>> Is the universal solution here referring to fix all the command line
>> parameters
>> in the kernel or this specific command line? Are we going to remove 
>> any
>> more
>> addition to the cmdline ;)
> 
> There are very few cases where a kernel command line parameter is the
> only way to configure something.  Most of the time it's just there to
> override a config.  I wouldn't suggest removing those.  I just don't
> want a kernel command line parameter to be the primary way to enable
> something.
> 

Agreed that command line parameters are not supposed to be some primary
way of setting things but an optional way to override settings, in this
case to override the strict mode already set by the driver. Then we can
probably agree that this command line is just an optional way provided
to the end user for his convenience? We would still need to find a 
primary
way to set this non-strict mode in drivers via DT passing the 
information
or some other way.

> 
>> So possible other solution is the *bootconfig* which is again just
>> another place
>> to look for a config. So thing is that this universal solution would
>> result in
>> just more new fancy ways of passing configs or adding such configs to
>> the drivers
>> or subsystems in kernel which is pretty much similar to implementing
>> policy in
>> kernel which I think is frowned upon and mentioned in the other 
>> thread.
>> 
>> > Ideally it feels like we should figure out how to tag devices in a
>> > generic manner automatically (hardcode at the driver or in the device
>> > tree).  I think the out-of-band discussions talked about "external
>> > facing" and the like.  We could also, perhaps, tag devices that have
>> > "binary blob" firmware if we wanted.  Then we'd have a policy (set by
>> > Kconfig, perhaps overridable via commandline) that indicated the
>> > strictness level for the various classes of devices.  So policy would
>> > be decided by KConfig and/or command line.
>> >
>> 
>> How is tagging in driver or device tree better than the simple command
>> line
>> approach to pass the same list of devices which otherwise you would
>> hardcode
>> in the corresponding drivers and device tree all over the kernel other
>> than
>> the scalability part for command line? IMHO it is too much churn.
> 
> It's better because it doesn't require keeping track and updating
> these per-board (or per machine) arguments for each and every
> board/machine you maintain.

If you choose to pass the information via DT which seems like the most 
ideal
way, then you would still have to update them per-board for every board 
you
maintain which is the same thing.

If, for instance, we start out by
> allowing HW video decoder to use non-strict.  So:
> 
> On one board, we add in "aa00000.video-codec" to the command line.
> On some other board, maybe we add in "1d00000.video-codec" to the 
> command line.
> On some other board, maybe we add in "90400000.video-codec" to the 
> command line.
> 
> Now we realize that there's some problem and we have to remove it, so
> we need to go through and remove this from our command line
> everywhere.  Worse is that we have to proactively notice it and remove
> it.
> 

Same as above where we need to modify DT to mark certain devices as 
strict
in case something goes wrong.

> Instead, let's imagine that we set a policy at a bit of a higher
> level.  Different ideas:
> 
> a) We could have a CONFIG_ option for the video codec that's something
> like "CONFIG_VIDEOCODEC_DEFAULT_NONSTRICT".  If this was set then if
> there is no "iommu.strict" command line argument then this device
> would be mapped as non-strict.  If "iommu.strict=0" or
> "iommu.strict=1" is on the command line then it would override all of
> these defaults.  Probably the existence (or maybe the default value)
> of this CONFIG option implies that there are no known/expected
> exploits related to it.
> 

Hmm, so then we'd have tens of Kconfigs for each device being non strict
by default?  Then I guess we'd need a menuconfig for this and where 
should
this go into, IOMMU layer or under respective drivers? Let's say we do 
this,
but how would the IOMMU know about such classes of devices, the only way 
I
can think of is adding such a field in "struct device" which can be 
tried
but may not be well received.

Also default should be strict in my opinion as it is today similar to 
bypassing
SMMU and then non strict option to override it.

> b) We could find some way to tag the video codec and then set
> non-strictness on certain classes of devices, then we could have a
> policy to disable strictness on certain classes of devices.
> 

If tagging is based on the DT property then we have ACPI to think about 
and it
poses the same problems which you listed for command line parameter 
where you
would have to go and update all the DT entries.

> The nice thing about the above is that you could imagine someone
> pushing a change to the stable trees that would fix everyone affected.
> Nobody would need to go around and adjust command line options, they'd
> just get the newest stable and it could cause devices to move into
> strict mode if there was a known exploit.  I suppose with your
> proposal stable trees could have a "blacklist" where the commandline
> is ignored for exploited devices, but that seems ugly.
> 

Yes this is true but then we can keep this cmdline parameter as only 
optional
and find a different way to enforce the non-strict mode setting.

> 
>> Device tree could be used but then we have a problem with it being for
>> only
>> describing hardware and it doesn't work for ACPI based systems.
>> 
>> Command line approach works for all systems (both DT and ACPI) without
>> having
>> to add too much churn to drivers. Lastly, I think we can have both
>> options, it
>> doesn't hurt to add command line parameter since it is optional.
> 
> I'm not opposed to something existing that lets you override this on
> the command line, but I'm just not a fan of it being the primary way.
> 

Agreed, so we can treat non-strict command line parameter as just 
optional
and we find a different way to set this mode in drivers via whatever 
method
everyone finds suitable.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
