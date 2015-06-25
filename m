From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 00/19] Fix Intel IOMMU breakage in kdump kernel
Date: Thu, 25 Jun 2015 09:06:40 +0100
Message-ID: <1435219600.8688.7.camel@infradead.org>
References: <1434178047-17809-1-git-send-email-joro@8bytes.org>
	  <1435066290.12045.2.camel@infradead.org> <20150623140631.GB2724@suse.de>
	 <1435070334.12045.24.camel@infradead.org> <558BA149.5060603@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <558BA149.5060603@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Li, ZhenHua" <zhen-hual@hp.com>
Cc: Joerg Roedel <jroedel@suse.de>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, bhe@redhat.com, ddutile@redhat.com, alex.williamson@redhat.com, dyoung@redhat.com, linux-kernel@vger.kernel.org, jroedel@8bytes.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2015-06-25 at 14:35 +0800, Li, ZhenHua wrote:
> Hi David,
> It is a bad idea to check the DMI match on "HP". Though I have not se=
e
> any similar problems on other systems, I believe there are. Also not
> all HP systems have such problem.

Yeah, the HP suggestion was a little tongue-in-cheek. Although it does
seem to be HP who is the main offender in this area =E2=80=94 both the =
BIOS
"value subtract" and the habit of doing utterly insane things with the
IOMMU.

> I agree with a blacklist for devices.

Do you have a list of the problematic ones? I think a blacklist *and*
an option to enable it for all devices might be the best solution.

--=20
dwmw2
