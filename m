From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v7 7/7] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Sat, 14 Jan 2017 09:58:29 +0700
Message-ID: <46834d61-d8b2-201f-99dd-5727994281a5@amd.com>
References: <1484019227-11473-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484019227-11473-8-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20170112175223.qsui53kln7vpmwop@pd.tnic>
	<6db9d730-b927-5a21-877c-fabb60b66bfe@amd.com>
	<20170113114925.x6f4r5qcidksnfes@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170113114925.x6f4r5qcidksnfes-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 1/13/17 18:49, Borislav Petkov wrote:
> On Fri, Jan 13, 2017 at 05:24:01PM +0700, Suravee Suthikulpanit wrote:
>> IIUC, Perf tools looks at the /sys/devices/xxxxx to identify
>> availalble PMUs. Are you planning to have perf tools look at
>> /sys/devices/system/iommu/xxx instead?
>
> No, I'm planning to understand what do you mean exactly. Because the
> PMUs are, as I'm being pointed to, here:
>
> #define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
>
> Do you mean that, per chance?
>

Ah, okay. I can see the following directory path:

# ls -l  /sys/devices/
drwxr-xr-x  5 root root 0 Jan 13 20:36 amd_iommu_0

# ls -l /sys/bus/event_source/devices/
lrwxrwxrwx 1 root root 0 Jan 13 20:33 amd_iommu_0 -> ../../../devices/amd_iommu_0

I'll update the commit log to mention /bus/event_source/devices/amd_iommu_X instead.

Thanks,
S
