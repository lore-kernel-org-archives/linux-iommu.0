From: Ronan Jouchet <ronan-RYxqDi3kOPxGWvitb5QawA@public.gmane.org>
Subject: Re: PROBLEM: intel_iommu=on under 4.13 breaks resume from suspend on
	my Thinkpad T560
Date: Fri, 29 Sep 2017 08:08:52 -0400
Message-ID: <34e8f4b2-b0d7-1fb5-a01d-62ac6b947072@jouchet.fr>
References: <3fc58417-93ff-f5eb-e9af-57ad378c6241@jouchet.fr>
	<20170929000019.GA102630@otc-nc-03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170929000019.GA102630@otc-nc-03>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Raj, Lu, thanks for the fast feedback :)

On 9/28/17 20:00, Raj, Ashok wrote:
> has it worked ever with intel_iommu=on?

Good point. I just tested that by rolling back to 4.12.13-1
and manually activating `intel_iommu=on`. As expected, no,
resume is similarly broken.

`intel_iommu={on, igfx_on}` probably have been breaking resume
for a long time on my system, I just happened to notice it now
due to being `on` by default.

On 9/29/17 00:29, Lu Baolu wrote:
 > I will look into it. But we will have a holiday till Oct. 8.
 > We probably won't see any progress before I am back.

Awesome! Note I will also be away mid-October, so if you
ask for feedback at this moment it might be a while before
I answer. But be sure I will.

Also, not sure if this is related or a separate bug, but looking at
my system logs I see two errors logged when `intel_iommu` is `on`:

     DMAR: DRHD: handling fault status reg 3
     DMAR: [DMA Read] Request device [00:12.4] fault addr b7fff000 
[fault reason 02] Present bit in context entry is clear

Feel free to ask for more info about that DMAR error, or ignore
it if you know it's irrelevant / already tracked elsewhere :)

Amending https://bugzilla.kernel.org/show_bug.cgi?id=197029 with
the new information.

Thanks again, good day everyone.
