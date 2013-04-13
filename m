From: Linda Knippers <linda.knippers-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH 0/9] AMD IOMMU cleanups, fixes and IVRS bug workarounds
Date: Sat, 13 Apr 2013 19:33:13 -0400
Message-ID: <5169EB39.5090908@hp.com>
References: <1365538384-12426-1-git-send-email-joro@8bytes.org>
	<CAKocOOP5tMsDLS8Wotu0kMNjSVJpN+pPhE9zj+n9ZKS9EcVR+A@mail.gmail.com>
	<20130412080637.GN6858@8bytes.org>
	<CAJtEV7aLa2tKw-B0f0ZNHdP86yxpvUAofs9eVPYCeib6m67f8g@mail.gmail.com>
	<20130413152602.GO6858@8bytes.org>
	<CAKocOOMZ-s-SHdJ0mb=EngiS2szGraK+=GNPpkmwALhi1hutnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAKocOOMZ-s-SHdJ0mb=EngiS2szGraK+=GNPpkmwALhi1hutnQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/13/13 19:14, Shuah Khan wrote:
> On Sat, Apr 13, 2013 at 9:26 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
>> On Sat, Apr 13, 2013 at 11:06:22PM +0800, Andrew Cooks wrote:
>>> On Fri, Apr 12, 2013 at 4:06 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
>>
>>>> Oh, that's sad. You were the only one having a machine wich actually has
>>>> unity-mapped ranges defined in the BIOS table. The code for those
>>>> mappings was basically untested before you ran it on that machine.
>>>>
>>> What is the machine in question? Maybe someone else has access to one,
>>> if it's not too exotic.
>>
>> Shuah had access to a HP server machine (don't know which one) that
>> defined unity-map ranges in the BIOS table. Shuah certainly knows the
>> details about that machine.
>>
> 
> Joerg/Andrew,
> 
> It is a DL385 Gen8 server. Unfortunately I left HP as of yesterday and no longer
> have access to the system. Maybe there others that have access to one.

Shuah, I think I know which machine you were using but if you'll send
me a note off list with the system details and what someone should look
for, I'll see if I can get someone to test.

-- ljk
> 
> -- Shuah
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
