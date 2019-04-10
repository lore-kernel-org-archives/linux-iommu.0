Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7751DC10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 12:50:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AD620818
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 12:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AD620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 14AC3180A;
	Wed, 10 Apr 2019 12:50:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A73D515BC
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 09:58:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id BE41A17E
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 09:58:33 +0000 (UTC)
Received: from mail-ot1-f71.google.com ([209.85.210.71])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1hE9zz-0002R6-Bx
	for iommu@lists.linux-foundation.org; Wed, 10 Apr 2019 09:58:31 +0000
Received: by mail-ot1-f71.google.com with SMTP id 7so741731otj.1
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 02:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
	bh=KoohZjKitUEMK19P8M8kJebhJSvNdrHlVwtrp8e1hTE=;
	b=HkKSIkd6hSKu3zsG0TM5L/HbErB/TJe0ocUeTwiIOrkJiygaSpwg/zYbHdLSbsXciq
	2uF1x9ILWrfAfO8qE2gohAr/GNlsK/gYKy1rU/az/NsvIW3ToqSWAz0U/f2+YnEj6Op+
	+UNaoAVOL/2M2pE27Bf7JtZW5HMgxhMwm+07eK1Q24MFir3cajrnLzFh2+gBq25/tZ4U
	yeTb0Ab0xTDrm3rfRR9MP+6f3ifZoP8FLB2II++EPwWHul1trGUTxx2WOfOIu/MkI+Fw
	S8y5cyI40BOLKnIqwJos5mN1UsMAbKxPY+b8fSGUijw1NVF+czalt31iNrf6i+6sWzpW
	LZQg==
X-Gm-Message-State: APjAAAVkMxyOQE52qfx2kInkaP3rIVwKlgulOvXXh1BBJNenO1lnWQqh
	t6cj9gD/JQP/g2Elhv2ri3nJEh7rB5DpPu96D2sV0lr+4+rireWZ98j7Vrwt5x8Z3Cxoi6OaImM
	xR2gewfpmaYl1s9XWvDTiKFFnc5VxRYXzRNVDTySqsqtd6DOHUWBfgbWvBDdYxpc=
X-Received: by 2002:a9d:6318:: with SMTP id q24mr26823856otk.95.1554890310380; 
	Wed, 10 Apr 2019 02:58:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxunOkpAjDDg39BekErUWsEldUn9btTTEXMtttqCcWAyJVLAYUYG6nemfNpZriQkdFghoQJyanYdEx6OsgtV4s=
X-Received: by 2002:a9d:6318:: with SMTP id q24mr26823842otk.95.1554890310157; 
	Wed, 10 Apr 2019 02:58:30 -0700 (PDT)
MIME-Version: 1.0
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 10 Apr 2019 11:58:04 +0200
Message-ID:
 <CAATJJ0Lhr5tjTfLRTpuntm-fmG6mT7QUZjVEAr+bvXy-04vzcw@mail.gmail.com>
Subject: Reporting crash fixed by intel_iommu=igfx_off
To: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org
X-Mailman-Approved-At: Wed, 10 Apr 2019 12:49:54 +0000
Cc: alex.williamson@redhat.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190410095804.GYJ-gk8hODOR4QJxMi0k0ldaKgQYnrdK5kVNeHL_rG4@z>

Hi,
I was working on an issue [1] triggered by MDEV passthrough to a KVM Guest.
I got recommended to try intel_iommu=igfx_off and it worked like a
charm allowing me to run opencl things in the guest on the device.

[2] still states for intel_iommu=igfx_off "If this fixes anything,
please ensure you file a bug reporting the problem.". While I'm not
sure how important that is to you still I thought to post you a
summary.
Maybe you are collecting a list of affected HW or anything like that?

If you want me to file a bugzilla or provide extra data let me know.
Here all the snippets I think you might consider helpful.

## Kernel Version ##
5.0.0-8-generic (Ubuntu)
The same kernel is active in Host and Guest.

## Crash ##
(before the fix by  intel_iommu=igfx_off)

[  245.284511] DMAR: DRHD: handling fault status reg 2
[  245.284530] DMAR: [DMA Write] Request device [00:02.0] fault addr
8c9128000 [fault reason 23] Unknown
[  245.284560] DMAR: DRHD: handling fault status reg 2
[  245.284579] DMAR: [DMA Write] Request device [00:02.0] fault addr
8c914a000 [fault reason 23] Unknown
[  245.284610] DMAR: DRHD: handling fault status reg 2
[  250.106273] [drm] GPU HANG: ecode 8:0:0xe757fefe, reason: no
progress on rcs0, action: reset
[  250.106274] [drm] GPU hangs can indicate a bug anywhere in the
entire gfx stack, including userspace.
[  250.106275] [drm] Please file a _new_ bug report on
bugs.freedesktop.org against DRI -> DRM/Intel
[  250.106276] [drm] drm/i915 developers can then reassign to the
right component if it's not a kernel issue.
[  250.106276] [drm] The gpu crash dump is required to analyze gpu
hangs, so please always attach it.
[  250.106277] [drm] GPU crash dump saved to /sys/class/drm/card0/error
[  250.106299] i915 0000:00:02.0: Resetting rcs0 for no progress on rcs0
[  251.900704] i915 0000:00:02.0: Resetting chip for no progress on rcs0
[  251.900718] i915 0000:00:02.0: GPU recovery failed


## HW Information ##

CPU: Intel(R) Core(TM) i5-5250U CPU @ 1.60GHz
$ lspci -v -s 00:02.0
00:02.0 VGA compatible controller: Intel Corporation HD Graphics 6000
(rev 09) (prog-if 00 [VGA controller])
        Subsystem: Intel Corporation HD Graphics 6000
        Flags: bus master, fast devsel, latency 0, IRQ 48
        Memory at f6000000 (64-bit, non-prefetchable) [size=16M]
        Memory at e0000000 (64-bit, prefetchable) [size=256M]
        I/O ports at f000 [size=64]
        [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
        Capabilities: <access denied>
        Kernel driver in use: i915
        Kernel modules: i915

## Mediated Devices passthrough setup ##

Enabled on kernel commandline via /etc/default/grub:
  i915.enable_gvt=1 intel_iommu=on drm.debug=0
And loading the modules:
  $ printf "kvmgt\nvfio-iommu-type1\nvfio-mdev" | sudo tee
/etc/initramfs-tools/modules

Update and reboot
 $ sudo update-initramfs -u
 $ sudo update-grub

Then I was creating a UUID for the MDEV
 $ cd /sys/bus/pci/devices/0000:00:02.0/mdev_supported_types/i915-GVTg_V4_4
 $ echo 4dd50f26-ec08-11e8-b838-4bc3356865b6 | sudo tee create

Finally I was telling libvirt to use that modifying my guest XML like
 <graphics type='spice'>
   <listen type='none'/>
   <gl enable='yes'/>
 </graphics>
 <hostdev mode='subsystem' type='mdev' managed='no' model='vfio-pci'>
   <source>
     <address uuid='4dd50f26-ec08-11e8-b838-4bc3356865b6'/>
   </source>
 </hostdev>


## guest workload to force-trigger the bug ##

Note: it could happen without it, but that proved to be faster than
waiting for the crash

Install opencl bits and try to use it, that would be:
 $ sudo apt install ocl-icd-libopencl1
 $ sudo apt install opencl-headers
 $ sudo apt install clinfo
 $ sudo apt install beignet
And then run clinfo
 $ clinfo


[1]: https://bugs.freedesktop.org/show_bug.cgi?id=110238
[2]: https://www.kernel.org/doc/Documentation/Intel-IOMMU.txt

P.S. the list won't send me the subscription confirmation - three
tries waited for an hour; so I expect to be at least moderated if not
denied on the list post :-/

-- 
Christian Ehrhardt
Software Engineer, Ubuntu Server
Canonical Ltd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
