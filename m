From: Bjorn Helgaas via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Add support for multiple DMA aliases
Date: Thu, 14 Jan 2016 08:07:59 -0800
Message-ID: <CAErSpo4kVvc4wvQhjA242TqozNLN-CNOScaK3T54SCLH_0Y36A@mail.gmail.com>
References: <1452518415-97637-1-git-send-email-jacek.lawrynowicz@intel.com>
	<1452720505.88154.71.camel@infradead.org>
	<20160114120356.GF8907@suse.de>
Reply-To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160114120356.GF8907-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 14, 2016 at 4:03 AM, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org> wrote:
> On Wed, Jan 13, 2016 at 09:28:25PM +0000, David Woodhouse wrote:
>> Acked-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>
>> Strictly speaking, this is more in PCI code than IOMMU code. And it
>> doesn't actually touch the Intel VT-d code at all; the subject is a bit
>> misleading.
>>
>> But I'm happy enough to add it to my intel-iommu tree if nobody else
>> picks it up. Bjorn?
>
> Yes, this is mostly PCI and should go through the Bjorn's tree.
>
> Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

I'll look at this tomorrow or early next week.
