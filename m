From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 7/7] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Fri, 13 Jan 2017 12:49:25 +0100
Message-ID: <20170113114925.x6f4r5qcidksnfes@pd.tnic>
References: <1484019227-11473-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1484019227-11473-8-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20170112175223.qsui53kln7vpmwop@pd.tnic>
 <6db9d730-b927-5a21-877c-fabb60b66bfe@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6db9d730-b927-5a21-877c-fabb60b66bfe@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, peterz@infradead.org, mingo@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 13, 2017 at 05:24:01PM +0700, Suravee Suthikulpanit wrote:
> IIUC, Perf tools looks at the /sys/devices/xxxxx to identify
> availalble PMUs. Are you planning to have perf tools look at
> /sys/devices/system/iommu/xxx instead?

No, I'm planning to understand what do you mean exactly. Because the
PMUs are, as I'm being pointed to, here:

#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"

Do you mean that, per chance?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
