From: Laine Stump <laine-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Regression in kernel 4.2.3+ (relative to 4.1.10) on AMD 990FX
	system with IOMMU enabled
Date: Fri, 5 Feb 2016 16:09:50 -0500
Message-ID: <56B50F9E.4040800@redhat.com>
References: <563A3F64.50808@redhat.com> <5644CD81.2020304@redhat.com>
	<20151118151841.GA2517@suse.de> <565F4CF5.90107@redhat.com>
	<20160120141025.GA13677@x1.redhat.com> <569F9D0E.20309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <569F9D0E.20309-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 01/20/2016 09:43 AM, Laine Stump wrote:
> On 01/20/2016 09:10 AM, Baoquan He wrote:
>> I found it archived in this place well:
>>
>> https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg10687.html
>>
>>
>> But pasted dmesg has been lost. putting "lspci -tv" and "lspci -vvv" is
>> more helpful.
>
> Sure, I'll boot it with the two kernels again today and recollect
> everything.
>
>
>> Besides does it work with latest kernel?
>
> I haven't tried the latest upstream recently, but the latest available
> pre-built for Fedora 23 (4.2.8-300.fc23) is even worse - at the place
> where it would previously hang for ~3 minutes, it now hangs "forever" (I
> accidentally rebooted with that kernel and left without checking;
> several hours later when I returned it was still hung).
>
> I'll also grab the latest upstream sources and build/test that today.

I finally built a 4.5.0-rc2+ kernel, and found that the problem has 
disappeared. So I also tried a locally built 4.3.0 (broken) and 4.4.0 
(works).

After another day of git bisect between v4.3 and v4.4, here's what I found:

commit 30e2561b95295258890b4e0366ce867e04d34a97 fails to boot
commit cbfe360a1541a32e9e28f8f8ac925d2b7979d767 works

It's notable that cbfe360a is in the igb driver, and I have an 82576 
card (which uses the igb driver) in my system. However:

1) That's not really related to the commit that seems to have caused the 
breakage (aafd8ba0ca74894b9397e412bbd7f8ea2662ead8) is it?

2) If I create a branch off of aafd8ba0c (or even v4.2) and cherry-pick 
commit cbfe360a (and ceee3450 to avoid a merge conflict) the result 
still fails to boot, so it's not a simple thing that just a patch or two 
can fix.

3) The good news: if I cherry-pick commit cbfe360a on top of v4.3 
(Fedora is currently using kernel 4.3) then the problem will be solved 
without needing to constantly switch back to a locally built kernel 
after every update.

My current working theory is that the changes in AMD iommu uncovered a 
latent bug in the igb driver, and that a series of patches to the igb 
driver (ending with cbfe360a) fixed that bug. I can't think of any other 
way to explain it (and I've rebuilt/retested on either side of every 
involved commit multiple times to verify the behavior).

So thanks for your interest, but I'm happy to say that this seems to be 
someone else's problem :-)
