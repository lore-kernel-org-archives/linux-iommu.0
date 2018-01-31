From: Thor Thayer <thor.thayer@linux.intel.com>
Subject: ARM64 SMMU Setup
Date: Wed, 31 Jan 2018 16:09:39 -0600
Message-ID: <fc00c99b-7766-2ac5-83a5-2ed9e13a15e1@linux.intel.com>
Reply-To: thor.thayer@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi,

I'm enabling the ARM SMMU-500 on an ARM64 A53. I'm hitting a data abort 
in the probe functions because I'm accessing the registers in EL1 mode.

Linux starts in EL2 mode but drops down to EL1 mode by the time it 
reaches the arm-smmu probe function.

Is there something else I need to add to either move the arm-smmu probe 
earlier or remain in EL2 until after the arm-smmu probe?

A Google search didn't turn up anything so I hoped posting to the list 
would help.

Thanks in advance,

Thor
