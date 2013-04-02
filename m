From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] iommu/amd: Add logic to decode AMD IOMMU event flag
Date: Tue, 2 Apr 2013 10:41:25 -0500
Message-ID: <515AFC25.5060501@amd.com>
References: <1364428283-2548-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20130402143335.GB15687@8bytes.org> <20130402144037.GE5488@pd.tnic>
	<20130402150302.GF15687@8bytes.org> <20130402152956.GE4391@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130402152956.GE4391-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 4/2/2013 10:29 AM, Borislav Petkov wrote:
> On Tue, Apr 02, 2013 at 05:03:04PM +0200, Joerg Roedel wrote:
>> On Tue, Apr 02, 2013 at 04:40:37PM +0200, Borislav Petkov wrote:
>>> While you guys are at it, can someone fix this too pls (ASUS board with
>>> a PD on it).
>>>
>>> [    0.220342] [Firmware Bug]: AMD-Vi: IOAPIC[9] not in IVRS table
>>> [    0.220398] [Firmware Bug]: AMD-Vi: IOAPIC[10] not in IVRS table
>>> [    0.220451] [Firmware Bug]: AMD-Vi: No southbridge IOAPIC found in IVRS table
>>> [    0.220506] AMD-Vi: Disabling interrupt remapping due to BIOS Bug(s)
>> That is actually a BIOS problem. I wonder whether it would help to turn this
>> into a WARN_ON to get the board vendors to release working BIOSes.
>> Opinions?
> Good luck trying to get ASUS to fix anything in their BIOS :(.
I have tried to contact Asus in the past to have them fix the issue, but 
I got no luck.  Once it is out in the field, it's very difficult to get 
them to make changes.  I am also addressing this issue with the BIOS 
team for the future hardware.

Turning this into WARN_ON() at this point might break a lot of systems 
currently out in the field.  However, users can always switching to use 
"intremap=off" but this might not be obvious.

Suravee

> Can't we detect the SB IOAPIC some other way in this case?
>
