From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu: Add config option to set passthrough as default
Date: Fri, 20 Jul 2018 10:37:29 -0700
Message-ID: <CAOesGMiaC8VXkYkgJF7h32ounC6hHNZtZjfW_xPcbw1cGKOT5w@mail.gmail.com>
References: <20180711205936.18614-1-olof@lixom.net>
	<20180720121619.pqrgth4zxdj7zjym@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180720121619.pqrgth4zxdj7zjym-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 20, 2018 at 5:16 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> Hi Olof,
>
> On Wed, Jul 11, 2018 at 01:59:35PM -0700, Olof Johansson wrote:
>> +config IOMMU_DEFAULT_PASSTHROUGH
>> +     bool "IOMMU passthrough by default"
>> +     depends on IOMMU_API
>> +        help
>> +       Enable passthrough by default (removing the need to pass in
>> +       iommu.passthrough=on through command line). If this is enabled,
>> +       you can still disable with iommu.passthrough=off
>> +
>> +       If unsure, say N here.
>> +
>
> The patch is a good start, but the description above indicates that it
> affects all IOMMU driver, which it does not. Please make the Intel and
> AMD IOMMU drivers also take this option into account.

It looks like it should make the AMD driver should honor it, since it
uses the generic infrastructure for domain types? But it also shares
iommu_pass_through variable usage with Intel, so if I change it over
there it'll be covered for sure.

One unfortunate thing here is the divergence in command line options
between arm64 and x86. I'll add a 'iommu=nopt' on x86 so it can be
turned off at runtime if enabled in config, but it'd be nice to also
have it adhere to the .passthrough options. That's a larger topic than
just this specific patch though.

Posting new patch shortly.


-Olof
