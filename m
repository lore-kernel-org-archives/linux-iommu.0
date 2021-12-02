Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D81C433EF
	for <iommu@archiver.kernel.org>; Thu,  2 Dec 2021 16:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 272B583E7E;
	Thu,  2 Dec 2021 16:26:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X9_atkJtZFPz; Thu,  2 Dec 2021 16:26:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BA21283E7F;
	Thu,  2 Dec 2021 16:26:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C94AC0012;
	Thu,  2 Dec 2021 16:26:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3799EC000A
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 16:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D83241D89
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 16:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=apertussolutions.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0BmakuEFK_Nl for <iommu@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 16:26:12 +0000 (UTC)
X-Greylist: delayed 00:15:03 by SQLgrey-1.8.0
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com
 [136.143.188.51])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0CA76409AD
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 16:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1638461440; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ef7/5KndNWTutWFlInIcn49PUdwFroAcNIVI7T1nYeb8Pe7cwRm0UMhiRJbIfJDrEGbWsXrVmwS2K2YAqqS+tiwmrH4Ahgk7IIlFcySQzasFv0FTsvKeqmMmeSHADU4ra7sWRyTFZCqS1TwA5i3nQpc8P8ukmzEMhP4Avd5TWcE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1638461440;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=lMSNaC8iHTZb79U0vyTj0xLlOB+ewHNQ8YYULYg6ndY=; 
 b=G8avNwaERXHBVta7/GOP+xxNti1Kca9EgBOmQgh4K5E5wop+LfQMRmehlWTLqvbKyX1YFk/ZQGyTg6UXGWd9HKeRC8c6K+4bXY8BhZZEs7Ja6y3Ydb9j/oSVt9HsAeqTfUxnuaVDrw4Skh2brupK+8ULeCUyQyrYd1MLMfO19M8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=apertussolutions.com;
 spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
 dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1638461440; 
 s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
 h=From:To:Cc:References:Subject:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=lMSNaC8iHTZb79U0vyTj0xLlOB+ewHNQ8YYULYg6ndY=;
 b=ZDhAHqpdCvwT8O5SVL4rT5hzDc0tFNRwrWO/x7qrfascQu4XC7ag6pjHeLC90XwO
 92OGdjmhJjqgX0ZuM6YF6fgmCXA7OnVzW4+LiTwMmt1qAKy5dcJmM1UU13chMCZklAo
 C2bP/fO3KHN0F2SYobN5q9X8eE5HGLByzkL9xDM0=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net
 [72.81.132.2]) by mx.zohomail.com
 with SMTPS id 1638461437855136.63909149380606;
 Thu, 2 Dec 2021 08:10:37 -0800 (PST)
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
To: Paul Moore <paul@paul-moore.com>,
 Ross Philipson <ross.philipson@oracle.com>, trenchboot-devel@googlegroups.com
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
 <CAHC9VhTJG24iG=U0geO-ZhC6OogxOu4icBrNY22+qRNpWd5PBQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
Message-ID: <456caf8c-b79a-e8b0-581f-3504240466ff@apertussolutions.com>
Date: Thu, 2 Dec 2021 11:09:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTJG24iG=U0geO-ZhC6OogxOu4icBrNY22+qRNpWd5PBQ@mail.gmail.com>
Content-Language: en-US
X-ZohoMailClient: External
Cc: linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 luto@amacapital.net, iommu@lists.linux-foundation.org, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, kanth.ghatraju@oracle.com,
 linux-integrity@vger.kernel.org, tglx@linutronix.de
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Paul!

On 11/30/21 8:06 PM, Paul Moore wrote:
> On Fri, Aug 27, 2021 at 9:20 AM Ross Philipson
> <ross.philipson@oracle.com> wrote:
>>
>> The larger focus of the Trechboot project (https://github.com/TrenchBoot) is to
>> enhance the boot security and integrity in a unified manner. The first area of
>> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
>> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
>> Trust for Measurement).
> 
> My apologies for such a late reply, but I'm just getting around to
> looking at this and I have a few questions on the basic design/flow
> (below) ...

No worries, thank you so much for taking the time to review.

>> The basic flow is:
>>
>>  - Entry from the dynamic launch jumps to the SL stub
> 
> So I'm clear, at this point the combined stub+kernel+initramfs+cmdline
> image has already been loaded into memory and the SL stub is
> executing, yes?

That is correct.

> As TrenchBoot seems to be focused on boot measurement and not
> enforcing policy, I'm guessing this is considered out-of-scope (not to
> mention that the combined stub+kernel image makes this less
> interesting), but has any thought been given to leveraging the TXT
> launch control policy, or is it simply an empty run-everything policy?

The TrenchBoot model is a bit different and takes a more flexible
approach to allow users to build tailored solutions. For instance Secure
Launch is able to be used in a configuration that is similar to tboot.
Consider the functions of tboot, it has a portion that is the
post-launch kernel that handles the handover from the ACM and a portion
that provides the Verified Launch policy engine, which is only capable
of enforcing policy on what is contained in the Multiboot chain. The
TrenchBoot approach is to introduce the Secure Launch capability into a
kernel, in this case Linux, to handle the handover from the ACM, and
then transition to a running user space that can contain a distribution
specific policy enforcement. As an example, the TrenchBoot project
contributed to the uroot project a Secure Launch policy engine which
enables the creation of an initramfs image which can then be embedded
into a minimal configuration Secure Launch Linux kernel. This results in
a single binary that functions like tboot but with a far richer and more
extensible policy engine.

With regard to TXT's Launch Control Policy, it is a function of SINIT
ACM and so it is still very much possible to be used with Secure Launch.
In fact such a configuration has been tested and used. Now it is out of
scope in the sense that the tboot project already maintains and provides
the lcptools suite for managing LCPs. If there is a requirement to use
an LCP, then the lcptools can be used to create a policy to only allow
the specific instance(s) of a Secure Launch kernel.

>>  - SL stub fixes up the world on the BSP
>>  - For TXT, SL stub wakes the APs, fixes up their worlds
>>  - For TXT, APs are left halted waiting for an NMI to wake them
>>  - SL stub jumps to startup_32
>>  - SL main locates the TPM event log and writes the measurements of
>>    configuration and module information into it.
> 
> Since the stub+kernel image are combined it looks like the kernel
> measurement comes from the ACM via the MLE measurement into PCR 18,
> while the stub generated measurements are extended into PCR 19 or 20
> depending on the configuration, yes?

If TXT is launched in Legacy PCR usage mode, then the bzImage, as loaded
into memory by the bootloader (GRUB), will be hashed into PCR 18. If it
is launched in the default Details and Authorities (DA) PCR usage mode,
then the bzImage will be hashed into PCR 17. This is because the kernel
has been promoted to being the MLE.

> I realize that moving the TXT code into the kernel makes this
> difficult (not possible?), but one of the things that was nice about
> the tboot based approach (dynamic, early launch) was that it could be
> extended to do different types of measurements, e.g. a signing
> authority measurement similar to UEFI Secure Boot and PCR 7.  If that
> is possible, I think it is something worth including in the design,
> even if it isn't initially implemented.  The only thing that
> immediately comes to mind would be a section/region based approach
> similar to systemd-boot/gummiboot where the (signed) kernel is kept in
> a well known region and verified/measured by the stub prior to jumping
> into its start point.

Revisiting the tboot-like configuration: the Secure Launch kernel, its
configuration (cmdline), and uroot initramfs (which may be embedded or
separate) are all part of the MLE started by the ACM. For tboot there is
the tboot binary and the VL policy, though uncertain if it was
configurable where the policy hash would be extended. Like the tboot VL
policy engine, the u-root policy engine is configurable where the
measurements are stored.

As highlighted, more components are measured as part of Secure Launch
than for tboot. The approach taken was to model after DA and put
binaries into 17 and configuration into 18. Later there were
requirements to isolate certain measurements. For the time this is
provided through kconfig to move config to 19 and initrd to 20. In the
future if/when additional measurements are incorporated, such as signing
keys that are embedded into the kernel, then it may be necessary to
provide a means to configure PCR usage at runtime.

>>  - Kernel boot proceeds normally from this point.
>>  - During early setup, slaunch_setup() runs to finish some validation
>>    and setup tasks.
>>  - The SMP bringup code is modified to wake the waiting APs. APs vector
>>    to rmpiggy and start up normally from that point.
>>  - SL platform module is registered as a late initcall module. It reads
>>    the TPM event log and extends the measurements taken into the TPM PCRs.
> 
> I'm sure there is some issue with passing data across boundaries, but
> is there any reason why the TPM event log needs to be updated
> out-of-sync with the TPM PCRs?  Is is possible to pass the
> measurements to the SL platform module which would both extend the
> PCRs and update the TPM event log at the same time?

Without rehashing the issues around TPM usage from the stub, the core
issue is that measurements need to be collected before usage which is at
a time when access to the TPM is not possible at this time. Thus the
measurements need to be collected and persisted in a location where they
can be retrieved when the main kernel is in control. It was felt using
the DRTM TPM log was a natural place as it persists all the info
necessary to record the measurements by the SL platform module. Though
it does result in there being two non-event entries to exist in the log
but those are standardized such that any TCG compliant log parser should
ignore them.

With the explanation of why it was done aside, if there is another
location that is preferred which can provide the necessary guarantees,
then there is no reason why they could not be switched to that location.

>>  - SL platform module initializes the securityfs interface to allow
>>    asccess to the TPM event log and TXT public registers.
>>  - Kernel boot finishes booting normally
>>  - SEXIT support to leave SMX mode is present on the kexec path and
>>    the various reboot paths (poweroff, reset, halt).
> 
> It doesn't look like it's currently implemented, but it looks like
> eventually you plan to support doing a new DRTM measurement on kexec,
> is that correct?  I'm sure that is something a *lot* of people
> (including myself) would like to see happen.

Correct, relaunch is not currently implemented but has always been
planned as relaunch enables DRTM late-launch use cases. For a few
reasons this is being elevated in priority and as a result there is a
short-term solution to quickly enable relaunch with longer term direct
integration into kexec.

Finally if your schedule allows it and it is not too much to ask, it
would be greatly appreciated if some code review could be provided.
Otherwise thank you for taking the time that you have to review the
approach.

V/r,
Daniel P. Smith
Apertus Solutions, LLC


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
